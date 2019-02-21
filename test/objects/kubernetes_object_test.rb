require 'test_helper'

class KubernetesObjectTest < Minitest::Test
  def test_metadata_created
    sut = Sunstone::Objects::KubernetesObject.new nil

    assert_instance_of Sunstone::Objects::KubernetesObjectMetadata, sut.metadata
  end

  def test_name_is_set_if_passed
    sut = Sunstone::Objects::KubernetesObject.new(:test)

    assert_equal :test, sut.metadata.name
  end

  def test_name_is_not_set_if_nil_is_passed
    sut = Sunstone::Objects::KubernetesObject.new(nil)

    assert_nil sut.metadata.name
  end
end
