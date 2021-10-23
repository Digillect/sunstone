class PropertyAttributesTest < Minitest::Test
  Property = Sunstone::Objects::Property

  def test_initialization_with_string_name
    sut = Property.new 'test'

    assert_kind_of Symbol, sut.name
    assert_equal :test, sut.name
  end

  def test_initialization_with_symbol_name
    sut = Property.new :test

    assert_kind_of Symbol, sut.name
    assert_equal :test, sut.name
  end

  def test_initialization_with_wrong_name
    assert_raises ArgumentError, 'Property name must be a String or Symbol' do
      Property.new 12
    end
  end

  def test_instance_variable_name_inflection
    sut = Property.new :test

    assert_equal '@test'.to_sym, sut.variable
  end

  def test_serialized_name_inflection
    sut = Property.new :underscored_name

    assert_equal :underscoredName, sut.serialized_name
  end

  def test_serialized_name_override
    sut = Property.new :readonly, serialized_name: :readOnly

    assert_equal :readOnly, sut.serialized_name
  end

  def test_invalid_serialized_name
    assert_raises ArgumentError, 'Serialized name must be a String or Symbol' do
      Property.new :readonly, serialized_name: 12
    end
  end

  def test_boolean_deduction_from_true_class
    sut = Property.new :test, TrueClass

    assert sut.boolean?
  end

  def test_boolean_deduction_from_false_class
    sut = Property.new :test, TrueClass

    assert sut.boolean?
  end

  def test_boolean_deduction_from_other_class
    sut = Property.new :test, Array

    refute sut.boolean?
  end

  def test_scalar_deduction_from_string
    sut = Property.new :test, String

    assert sut.scalar?
  end

  def test_scalar_deduction_from_integer
    sut = Property.new :test, Integer

    assert sut.scalar?
  end

  def test_scalar_deduction_from_float
    sut = Property.new :test, Float

    assert sut.scalar?
  end

  def test_scalar_deduction_from_true_class
    sut = Property.new :test, TrueClass

    assert sut.scalar?
  end

  def test_scalar_deduction_from_false_class
    sut = Property.new :test, FalseClass

    assert sut.scalar?
  end

  def test_scalar_deduction_from_random_class
    sut = Property.new :test, Class.new

    refute sut.scalar?
  end
  def test_array_deduction_from_array
    sut = Property.new :test, Array

    assert sut.array?
  end

  def test_array_deduction_from_inherited_array
    klass = Class.new(Array)

    sut = Property.new :test, klass

    assert sut.array?
  end
end
