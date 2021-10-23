class ConfigMapOrSecretEnvSourceTest < Minitest::Test
  def test_initialization
    sut = Sunstone::Objects::ConfigMapOrSecretEnvSource.new :test

    assert_equal :test, sut.name
    assert_nil sut.optional
  end

  def test_optional_is_readonly
    sut = Sunstone::Objects::ConfigMapOrSecretEnvSource.new :test, true

    refute sut.respond_to? 'optional='
    refute sut.respond_to? 'optional!'
  end

  def test_serialization
    sut = Sunstone::Objects::ConfigMapOrSecretEnvSource.new :test, true

    assert_equal({ name: 'test', optional: true }.to_a, sut.to_hash.to_a)
  end
end
