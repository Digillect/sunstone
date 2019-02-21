require 'test_helper'

class CustomResourceTest < Minitest::Test
  R.register_custom_resource :test_resource, 'Test', 'example.org/v1'

  def test_resource_creation
    sut = R.test_resource :test

    assert_equal 'Test', sut.kind
    assert_equal 'example.org/v1', sut.api_version
  end

  def test_field_set_in_initializer
    sut = R.test_resource :test, spec: { value: 1 }

    hash = sut.to_hash

    assert_equal 1, hash[:spec][:value]
  end
end
