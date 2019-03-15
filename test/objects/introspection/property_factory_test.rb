require 'test_helper'
require 'sunstone/objects/introspection/property_descriptor'
require 'sunstone/objects/introspection/property_factory'

class PropertyFactoryTest < Minitest::Test
  PD = Sunstone::Objects::Introspection::PropertyDescriptor
  PF = Sunstone::Objects::Introspection::PropertyFactory

  def test_readonly_scalar_property_factory
    klass = create_klass :value, Integer, readonly: true

    assert klass.method_defined? 'value'
    refute klass.method_defined? 'value='
    refute klass.method_defined? 'value?'
    refute klass.method_defined? 'value!'
  end

  def test_scalar_property_factory
    klass = create_klass :value, Integer

    assert klass.method_defined? 'value'
    assert klass.method_defined? 'value='
    refute klass.method_defined? 'value?'
    refute klass.method_defined? 'value!'
  end

  def test_readonly_boolean_property_factory
    klass = create_klass :value, TrueClass, readonly: true

    assert klass.method_defined? 'value'
    assert klass.method_defined? 'value?'
    refute klass.method_defined? 'value='
    refute klass.method_defined? 'value!'
  end

  def test_readonly_complex_property_factory
    klass = create_klass :value, Hash, readonly: true

    assert klass.method_defined? 'value'
    refute klass.method_defined? 'value='
    refute klass.method_defined? 'value?'
    refute klass.method_defined? 'value!'
  end

  def test_complex_property_factory
    klass = create_klass :value, Hash

    assert klass.method_defined? 'value'
    refute klass.method_defined? 'value='
    refute klass.method_defined? 'value?'
    refute klass.method_defined? 'value!'
  end

  def test_readonly_scalar_property_reader_returns_value
    klass = create_klass :value, Integer, readonly: true do
      @value = 42
    end

    sut = klass.new

    assert_equal 42, sut.value
  end

  def test_readonly_scalar_property_reader_ignores_argument
    klass = create_klass :value, Integer, readonly: true

    sut = klass.new

    assert_raises ArgumentError, 'wrong number of arguments (given 1, expected 0)' do
      sut.value 42
    end
  end

  def test_readonly_scalar_property_reader_ignores_block
    klass = create_klass :value, Integer, readonly: true

    sut = klass.new
    called = false

    sut.value do
      called = true
    end

    refute called, 'Readonly scalar property reader should not call block'
  end

  def test_scalar_property_reader_returns_value
    klass = create_klass :value, Integer do
      @value = 42
    end

    sut = klass.new

    assert_equal 42, sut.value
  end

  def test_scalar_property_reader_works_as_writer
    klass = create_klass :value, Integer

    sut = klass.new

    sut.value 42

    assert 42, sut.value
  end

  def test_scalar_property_reader_ignores_block
    klass = create_klass :value, Integer

    sut = klass.new
    called = false

    sut.value do
      called = true
    end

    refute called, 'Readonly scalar property reader should not call block'
  end

  def test_boolean_property_question_mark_reader
    klass = create_klass :readonly, TrueClass do
      @readonly = true
    end

    sut = klass.new

    assert sut.readonly?
  end

  def test_scalar_property_writer
    klass = create_klass :value, Integer

    sut = klass.new

    sut.value = 42

    assert_equal 42, sut.value
  end

  def test_boolean_property_bang_writer
    klass = create_klass :value, TrueClass

    sut = klass.new

    sut.value!

    assert sut.value
  end

  def test_complex_property_reader_returns_value
    klass = create_klass :value, Array do
      @value = %w[hello]
    end

    sut = klass.new

    assert_equal %w[hello], sut.value
  end

  def test_complex_property_reader_ignores_argument
    klass = create_klass :value, Hash

    sut = klass.new

    assert_raises ArgumentError, 'wrong number of arguments (given 1, expected 0)' do
      sut.value 42
    end
  end

  def test_readonly_complex_property_reader_ignores_argument
    klass = create_klass :value, Hash, readonly: true

    sut = klass.new

    assert_raises ArgumentError, 'wrong number of arguments (given 1, expected 0)' do
      sut.value 42
    end
  end

  def test_complex_property_evaluates_block_in_the_context_of_the_property
    array = %w[hello]
    result = nil

    klass = create_klass :value, Array do
      @value = array
    end

    sut = klass.new

    sut.value do
      result = self
    end

    assert_same array, result
  end
  def create_klass(name, klass, item_klass = nil, readonly: false, &block)
    pd = PD.new name, klass, item_klass, readonly: readonly
    pf = PF.new pd

    klass = Class.new

    klass.send :define_method, :initialize, &block if block_given?

    pf.create_methods klass

    klass
  end
end
