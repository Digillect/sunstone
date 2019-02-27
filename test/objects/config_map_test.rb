require 'test_helper'
require 'sunstone/objects/config_map'

class ConfigMapTest < Minitest::Test
  def test_serialization
    sut = Sunstone::Objects::ConfigMap.new :test

    sut.set key: 'value'

    expected = {
      apiVersion: 'v1',
      kind: 'ConfigMap',
      metadata: {
        name: 'test'
      },
      data: {
        key: 'value'
      }
    }

    assert_equal expected, sut.to_hash
  end
end
