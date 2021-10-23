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
        super()

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
        super()

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

  def test_add_or_replace_adds_object_if_not_found
    item_klass = Class.new do
      attr_reader :name, :value

      def initialize(name, value)
        super()

        @name = name
        @value = value
      end
    end

    sut << item_klass.new(:key1, 1)
    sut << item_klass.new(:key2, 2)
    sut << item_klass.new(:key3, 3)

    sut.add_or_replace item_klass.new(:key4, 4), ->(v) { v.name == :key4 }

    assert_equal 4, sut.length

    second = sut[3]

    assert_equal :key4, second.name
    assert_equal 4, second.value
  end

  def test_add_or_replace_replaces_object_if_found
    item_klass = Class.new do
      attr_reader :name, :value

      def initialize(name, value)
        super()

        @name = name
        @value = value
      end
    end

    sut << item_klass.new(:key1, 1)
    sut << item_klass.new(:key2, 2)
    sut << item_klass.new(:key3, 3)

    sut.add_or_replace item_klass.new(:key2, 4), ->(v) { v.name == :key2 }

    assert_equal 3, sut.length

    second = sut[1]

    assert_equal :key2, second.name
    assert_equal 4, second.value
  end
end
