require 'test_helper'
require 'sunstone/objects/client_ip_config'

class ClientIPConfigTest < Minitest::Test
  def test_initialization
    sut = Sunstone::Objects::ClientIPConfig.new

    assert_nil sut.timeout_seconds
  end

  def test_empty_without_value
    sut = Sunstone::Objects::ClientIPConfig.new

    assert sut.empty?
  end

  def test_not_empty_with_value
    sut = Sunstone::Objects::ClientIPConfig.new

    sut.timeout_seconds = 42

    refute sut.empty?
  end

  def test_serialization
    sut = Sunstone::Objects::ClientIPConfig.new

    sut.timeout_seconds = 42

    assert_equal_hash({ timeoutSeconds: 42 }, sut.to_hash)
  end
end
