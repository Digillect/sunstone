require 'test_helper'
require 'sunstone/objects/base_object'
require 'sunstone/objects/parentable'

class BaseObjectTest < Minitest::Test
  def test_properties_are_remembered
    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :a
    end

    assert_equal [:a], klass.properties.map(&:name)
  end

  def test_properties_are_not_mixed
    klass1 = Class.new(Sunstone::Objects::BaseObject) do
      property :a
    end

    klass2 = Class.new(Sunstone::Objects::BaseObject) do
      property :b
    end

    assert_equal [:a], klass1.properties.map(&:name)
    assert_equal [:b], klass2.properties.map(&:name)
  end

  def test_properties_are_not_duplicated
    klass1 = Class.new(Sunstone::Objects::BaseObject) do
      property :a
    end

    klass2 = Class.new(Sunstone::Objects::BaseObject) do
      property :a
    end

    assert_equal [:a], klass1.properties.map(&:name)
    assert_equal [:a], klass2.properties.map(&:name)
  end

  def test_inherited_properties_are_not_mixed
    base_klass = Class.new(Sunstone::Objects::BaseObject) do
      property :a
    end

    klass1 = Class.new(base_klass) do
      property :b
    end

    klass2 = Class.new(base_klass) do
      property :c
    end

    assert_equal [:a], base_klass.properties.map(&:name)
    assert_equal %i[a b], klass1.properties.map(&:name)
    assert_equal %i[a c], klass2.properties.map(&:name)
  end

  def test_property_declaration
    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :name, String
    end

    sut = klass.new

    assert sut.respond_to? 'name'
    assert sut.respond_to? 'name='
  end

  def test_boolean_property_declaration
    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :name, TrueClass
    end

    sut = klass.new

    assert sut.respond_to? 'name'
    assert sut.respond_to? 'name='
    assert sut.respond_to? 'name!'
    assert sut.respond_to? 'name?'
  end

  def test_readonly_property_declaration
    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :items, Array
    end

    sut = klass.new

    assert sut.respond_to? 'items'
    refute sut.respond_to? 'items='
    refute sut.respond_to? 'items!'
    refute sut.respond_to? 'items?'
  end

  def test_property_getter_is_not_created_if_already_defined
    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :value

      def value(first_value = nil, second_value = nil)
        return @value unless first_value && second_value

        @value = "#{first_value} #{second_value}"
      end
    end

    sut = klass.new

    assert_nil sut.value

    sut.value 'first', 'second'

    assert_equal 'first second', sut.value
  end

  def test_property_default_value
    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :name
    end

    sut = klass.new

    assert_nil sut.name
  end

  def test_empty_for_fresh_instance
    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :value, Integer
    end

    sut = klass.new

    assert_empty sut
  end

  def test_empty_when_not_empty
    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :value, Integer
    end

    sut = klass.new

    sut.value = 42

    refute_empty sut
  end

  def test_empty_with_extra_properties_empty
    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :value, Integer

      protected

      def extra_properties_empty?
        false
      end
    end

    sut = klass.new

    refute_empty sut
  end

  def test_object_serialization
    value_klass = Class.new do
      attr_accessor :value

      def initialize
        @value = 42
      end

      def to_hash
        { value: @value }
      end
    end

    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :item, readonly: true
    end

    klass.send(:define_method, :initialize) do
      super()

      @item = value_klass.new
    end

    sut = klass.new

    assert_equal_hash({ item: { value: 42 } }, sut.to_hash)
  end

  def test_array_of_objects_serialization
    value_klass = Class.new do
      attr_accessor :value

      def initialize(value)
        @value = value
      end

      def to_hash
        { value: @value }
      end
    end

    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :items, readonly: true

      def initialize
        super

        @items = []
      end
    end

    sut = klass.new

    sut.items << value_klass.new(42)
    sut.items << value_klass.new(43)

    assert_equal({ items: [{ value: 42 }, { value: 43 }] }, sut.to_hash)
  end

  def test_empty_array_serialization
    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :items, readonly: true

      def initialize
        @items = []
      end
    end

    sut = klass.new

    assert_equal({}, sut.to_hash)
  end

  def test_empty_object_serialization
    value_klass = Class.new do
      def empty?
        true
      end

      def to_hash
        { a: 2 }
      end
    end

    klass = Class.new(Sunstone::Objects::BaseObject) do
      property :items, readonly: true
    end

    klass.send(:define_method, :initialize) do
      super()

      @items = value_klass.new
    end

    sut = klass.new

    assert_equal({}, sut.to_hash)
  end

  def test_parentable_property_receives_parent_on_initialization
    parentable = Class.new do
      include Sunstone::Objects::Parentable
    end

    klass = Class.new Sunstone::Objects::BaseObject do
      property :value, parentable
    end

    sut = klass.new

    assert_same sut, sut.value.__parent
  end

  def test_parentable_chain_resolution
    parentable = Class.new do
      include Sunstone::Objects::Parentable
    end

    inner = Class.new Sunstone::Objects::BaseObject do
      property :second, parentable
    end

    klass = Class.new Sunstone::Objects::BaseObject do
      property :first, inner
    end

    sut = klass.new

    assert_same sut, sut.first.__parent
    assert_same sut.first, sut.first.second.__parent
    assert_same sut, sut.first.second.__root
  end
end
