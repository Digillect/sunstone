require 'test_helper'
require 'base64'
require 'sunstone/objects/secret'

class SecretTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::Secret.new :test
  end

  def test_serialization
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

    assert_equal expected.to_a, sut.to_hash.to_a
  end
end
