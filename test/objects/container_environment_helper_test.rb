require 'test_helper'
require 'sunstone/objects/container_environment_helper'
require 'sunstone/objects/env_var'
require 'sunstone/objects/env_var_source'

class ContainerEnvironmentHelperTest < Minitest::Test
  attr_reader :sut, :env, :env_from

  def setup
    @env = Sunstone::Objects::BaseArray.new
    @env_from = Sunstone::Objects::BaseArray.new
    @sut = Sunstone::Objects::ContainerEnvironmentHelper.new @env, @env_from, :test
  end

  def test_add_adds_single_value
    sut.add LEVEL: :debug

    assert_equal 1, env.length

    first = @env[0]

    assert_equal :LEVEL, first.name
    assert_equal 'debug', first.value
  end

  def test_add_adds_multiple_value
    sut.add LEVEL: :debug, ANSWER: 42

    assert_equal 2, env.length

    first = env[0]
    second = env[1]

    assert_equal :LEVEL, first.name
    assert_equal 'debug', first.value
    assert_equal :ANSWER, second.name
    assert_equal '42', second.value
  end

  def test_add_overwrites_existing_value
    sut.add LEVEL: :debug
    sut.add LEVEL: 42

    assert_equal 1, env.length

    first = env[0]

    assert_equal :LEVEL, first.name
    assert_equal '42', first.value
  end

  def test_use_config_map_do_not_adds_reference_if_already_exists
    sut.use_config_map
    sut.use_config_map

    assert_equal 1, env_from.length
  end

  def test_use_config_map_and_use_secret_do_not_overlap
    sut.use_config_map
    sut.use_secret

    assert_equal 2, env_from.length
  end
end
