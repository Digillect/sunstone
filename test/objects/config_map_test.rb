class ConfigMapTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::ConfigMap.new :test
  end

  def test_serialization
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

  def test_capitalization
    sut.set Sms__Enabled: 'value', AWS_KEY: 'value'

    hash_keys = sut.to_hash[:data].keys.map(&:to_s)

    assert_equal %w[Sms__Enabled AWS_KEY], hash_keys
  end
end
