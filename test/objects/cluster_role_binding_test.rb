require 'test_helper'
require 'sunstone/objects/cluster_role_binding'

class ClusterRoleBindingTest < Minitest::Test
  def test_initialization
    sut = Sunstone::Objects::ClusterRoleBinding.new :test

    assert_nil sut.role_ref
    assert_empty sut.subjects
  end

  def test_cluster_role
    sut = Sunstone::Objects::ClusterRoleBinding.new :test

    sut.cluster_role :users

    refute_nil sut.role_ref
    assert_equal :users, sut.role_ref.name
    assert_equal :ClusterRole, sut.role_ref.kind
    assert_equal 'rbac.authorization.k8s.io', sut.role_ref.api_group
  end

  def test_add_user
    sut = Sunstone::Objects::ClusterRoleBinding.new :test

    sut.add_user :johndoe

    refute_empty sut.subjects

    subject = sut.subjects.first

    assert_equal :User, subject.kind
    assert_equal :johndoe, subject.name
    assert_nil subject.namespace
    assert_nil subject.api_group
  end

  def test_serialization
    sut = Sunstone::Objects::ClusterRoleBinding.new :test

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
