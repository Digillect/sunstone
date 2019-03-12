require 'test_helper'
require 'sunstone/objects/node_selector_requirement_array'

class NodeSelectorRequirementArrayTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::NodeSelectorRequirementArray.new
  end

  def test_exists
    sut.exists :test

    refute_empty sut

    item = sut.first

    assert_equal :test, item.key
    assert_equal 'Exists', item.operator
    assert_nil item.values
  end

  def test_does_not_exists
    sut.does_not_exists :test

    refute_empty sut

    item = sut.first

    assert_equal :test, item.key
    assert_equal 'DoesNotExists', item.operator
    assert_nil item.values
  end

  def test_in
    sut.in :test, :a, :b, :c

    refute_empty sut

    item = sut.first

    assert_equal :test, item.key
    assert_equal 'In', item.operator
    refute_empty item.values
    assert_equal %i[a b c], item.values
  end

  def test_in_requires_values
    assert_raises ArgumentError, "Operator 'In' requires a list of values" do
      sut.in :test
    end
  end

  def test_not_in
    sut.not_in :test, :a, :b, :c

    refute_empty sut

    item = sut.first

    assert_equal :test, item.key
    assert_equal 'NotIn', item.operator
    refute_empty item.values
    assert_equal %i[a b c], item.values
  end

  def test_not_in_requires_values
    assert_raises ArgumentError, "Operator 'NotIn' requires a list of values" do
      sut.not_in :test
    end
  end

  def test_less_than
    sut.less_than :test, 12

    refute_empty sut

    item = sut.first

    assert_equal :test, item.key
    assert_equal 'Lt', item.operator
    refute_empty item.values
    assert_equal [12], item.values
  end

  def test_less_than_requires_integer_value
    assert_raises ArgumentError, "Operator 'Lt' requires an Integer value" do
      sut.less_than :test, :value
    end
  end

  def test_lt
    sut.lt :test, 12

    refute_empty sut

    item = sut.first

    assert_equal :test, item.key
    assert_equal 'Lt', item.operator
    refute_empty item.values
    assert_equal [12], item.values
  end

  def test_greater_than
    sut.greater_than :test, 12

    refute_empty sut

    item = sut.first

    assert_equal :test, item.key
    assert_equal 'Gt', item.operator
    refute_empty item.values
    assert_equal [12], item.values
  end

  def test_greater_than_requires_integer_value
    assert_raises ArgumentError, "Operator 'Gt' requires an Integer value" do
      sut.greater_than :test, :value
    end
  end

  def test_gt
    sut.gt :test, 12

    refute_empty sut

    item = sut.first

    assert_equal :test, item.key
    assert_equal 'Gt', item.operator
    refute_empty item.values
    assert_equal [12], item.values
  end
end
