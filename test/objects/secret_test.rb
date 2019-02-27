require 'test_helper'
require 'base64'
require 'sunstone/objects/secret'

class SecretTest < Minitest::Test
  def test_serialization
    sut = Sunstone::Objects::Secret.new :test

    sut.set key: 'value'

    expected = {
      apiVersion: 'v1',
      kind: 'Secret',
      metadata: {
        name: 'test'
      },
      data: {
        key: Base64.strict_encode64('value')
      }
    }

    assert_equal expected, sut.to_hash
  end
end
