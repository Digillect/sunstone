require 'test_helper'
require 'sunstone/objects/custom_resource'

class CustomResourceTest < Minitest::Test
  def test_fields
    sut = TestResource.new :test

    sut.fields.spec = { value: 1 }

    hash = sut.to_hash

    assert_equal 1, hash[:spec][:value]
  end

  class TestResource < Sunstone::Objects::CustomResource
    def api_version
      'example.org/v1'
    end
  end
end
