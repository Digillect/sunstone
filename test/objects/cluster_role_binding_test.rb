require 'test_helper'
require 'sunstone/objects/cluster_role_binding'

class ClusterRoleBindingTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::ClusterRoleBinding.new :test
  end

  def test_properties_and_methods
    assert_property sut, :role_ref
    assert_property sut, :subjects

    assert_kind_of Sunstone::Objects::BaseArray, sut.subjects

    assert_respond_to sut, :cluster_role
    assert_respond_to sut, :add_user
    assert_respond_to sut, :add_group
    assert_respond_to sut, :add_service_account
  end

  def test_cluster_role
    sut.cluster_role :users

    refute_nil sut.role_ref
    assert_equal :users, sut.role_ref.name
    assert_equal :ClusterRole, sut.role_ref.kind
    assert_equal 'rbac.authorization.k8s.io', sut.role_ref.api_group
  end

  def test_add_user
    sut.add_user :johndoe

    refute_empty sut.subjects

    subject = sut.subjects.first

    assert_equal :User, subject.kind
    assert_equal :johndoe, subject.name
    assert_nil subject.namespace
    assert_nil subject.api_group
  end

  def test_serialization
    sut.cluster_role :users
    sut.add_user :johndoe

    expected = {
      apiVersion: 'rbac.authorization.k8s.io/v1',
      kind: 'ClusterRoleBinding',
      metadata: {
        name: 'test'
      },
      roleRef: {
        kind: 'ClusterRole',
        name: 'users',
        apiGroup: 'rbac.authorization.k8s.io'
      },
      subjects: [
        {
          kind: 'User',
          name: 'johndoe'
        }
      ]
    }

    assert_equal expected.to_a, sut.to_hash.to_a
  end
end
