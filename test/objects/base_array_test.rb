require 'test_helper'
require 'sunstone/objects/base_array'

class BaseArrayTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::BaseArray.new
  end

  def test_push_sets_parent
    item_klass = Class.new do
      include Sunstone::Objects::Parentable
    end

    root = item_klass.new
    item = item_klass.new

    sut.__parent = root
    sut.push item

    assert_same sut, item.__parent
    assert_same root, item.__root
  end

  def test_each
    item_klass = Class.new do
      include Sunstone::Objects::Parentable

      def initialize(value)
        @value = value
      end

      attr_accessor :value
    end

    sut.push item_klass.new 1
    sut.push item_klass.new 2
    sut.push item_klass.new 3

    result = 0

    sut.each do |item|
      result += item.value
    end

    assert_equal 6, result
  end

  def test_enumerable
    item_klass = Class.new do
      include Sunstone::Objects::Parentable

      def initialize(value)
        @value = value
      end

      attr_accessor :value
    end

    sut.push item_klass.new 1
    sut.push item_klass.new 2
    sut.push item_klass.new 3

    result = sut.reduce(0) { |sum, item| sum + item.value }

    assert_equal 6, result
  end
end
