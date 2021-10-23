class RollingUpdateDaemonSetTest < Minitest::Test
  def setup
    @sut = Sunstone::Objects::RollingUpdateDaemonSet.new
  end

  def test_default_values
    assert_nil @sut.max_unavailable
  end

  def test_emptiness
    assert_empty @sut
  end

  def test_serialization
    @sut.max_unavailable '20%'

    assert_equal_hash({ maxUnavailable: '20%' }, @sut.to_hash)
  end

  def test_valid_max_unavailable_absolute_count
    @sut.max_unavailable 5

    assert_equal 5, @sut.max_unavailable
  end

  def test_invalid_max_unavailable_absolute_count
    assert_raises ArgumentError, "max_unavailable's value should be greater than zero" do
      @sut.max_unavailable 0
    end
  end

  def test_valid_max_unavailable_percentage
    @sut.max_unavailable '12%'

    assert_equal '12%', @sut.max_unavailable
  end

  def test_invalid_max_unavailable_percentage_without_percentage_sign
    assert_raises ArgumentError, "max_unavailable's value should be an integer between 1 and 100 and ends with a percent sign" do
      @sut.max_unavailable '12'
    end
  end

  def test_invalid_max_unavailable_percentage_with_non_digits
    assert_raises ArgumentError, "max_unavailable's value should be an integer between 1 and 100 and ends with a percent sign" do
      @sut.max_unavailable '1a%'
    end
  end

  def test_invalid_max_unavailable_percentage_with_out_of_range_value
    assert_raises ArgumentError, "max_unavailable's value should be an integer between 1 and 100 and ends with a percent sign" do
      @sut.max_unavailable '150%'
    end
  end
end
