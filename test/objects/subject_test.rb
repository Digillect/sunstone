require 'test_helper'
require 'sunstone/objects/subject'

class SubjectTest < Minitest::Test
  def test_initialization
    sut = Sunstone::Objects::Subject.new(:ConfigMap, :test, :default)

    assert_equal :ConfigMap, sut.kind
    assert_equal :test, sut.name
    assert_equal :default, sut.namespace
    assert_nil sut.api_group
  end

  def test_serialization
    sut = Sunstone::Objects::Subject.new(:ConfigMap, :test, :default)

    assert_equal({ kind: 'ConfigMap', name: 'test', namespace: 'default' }.to_a, sut.to_hash.to_a)
  end
end
