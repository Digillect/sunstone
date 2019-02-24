require 'test_helper'
require 'sunstone/objects/daemon_set_update_strategy'

class DaemonSetUpdateStrategyTest < Minitest::Test
  def setup
    @sut = Sunstone::Objects::DaemonSetUpdateStrategy.new
  end

  def test_default_values
    assert_equal 'RollingUpdate', @sut.type
    refute_nil @sut.rolling_update
  end

  def test_valid_type_on_delete
    @sut.type 'OnDelete'

    assert 'OnDelete', @sut.type
  end

  def test_empty_with_default_values
    assert_empty @sut
  end

  def test_not_empty_with_on_delete_type
    @sut.type 'OnDelete'

    refute_empty @sut
  end
end
