class ResourceRequirementsSetTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::ResourceRequirementsSet.new
  end

  def test_empty_on_fresh_instance
    assert_empty sut
  end

  def test_empty
    sut.cpu '100m'

    refute_empty sut
  end

  def test_setting_value_as_string
    sut.cpu '100m'

    assert sut.cpu, '100m'
  end

  def test_setting_value_as_float
    sut.cpu 0.5

    assert sut.cpu, 0.5
  end

  def test_setting_extended_resource
    sut.extended_resource 'example.com/foo', 0.5

    assert 0.5, sut.extended_resource('example.com/foo')
  end

  def test_serialization
    sut.cpu '100m'
    sut.storage '5Gi'
    sut.ephemeral_storage '4Gi'
    sut.extended_resource 'example.com/foo', 0.5

    expected = {
      cpu: '100m',
      storage: '5Gi',
      'ephemeral-storage': '4Gi',
      'example.com/foo': 0.5
    }

    actual = sut.to_hash

    assert_equal_hash expected, actual
  end
end
