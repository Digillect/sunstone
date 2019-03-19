require 'active_support'
require 'active_support/core_ext'

module Sunstone
  module Objects
    class Property
      attr_reader :name, :serialized_name, :string_name, :variable
      attr_reader :klass, :item_klass
      attr_accessor :serializer, :item_serializer

      def initialize(name, klass = nil, item_klass = nil, serialized_name: nil, initialize: nil, readonly: false, test_emptiness: true)
        raise ArgumentError, 'Property name must be a String or Symbol' unless name.is_a?(String) || name.is_a?(Symbol)
        raise ArgumentError, 'Serialized name must be a String or Symbol' unless serialized_name.nil? || serialized_name.is_a?(String) || serialized_name.is_a?(Symbol)

        string_name = name.to_s
        serialized_name ||= string_name.camelize(:lower)

        @name = string_name.to_sym
        @variable = "@#{string_name}".to_sym
        @string_name = name.to_s
        @serialized_name = serialized_name.to_sym

        @klass = klass
        @item_klass = item_klass

        @initialize = initialize
        @readonly = readonly
        @test_emptiness = test_emptiness

        @scalar = nil
        @boolean = nil
        @array = nil
      end

      def initialize?
        @initialize.nil? || @initialize.is_a?(TrueClass) || @initialize.is_a?(Proc)
      end

      def readonly?
        @readonly
      end

      def test_emptiness?
        @test_emptiness
      end

      def boolean?
        @boolean = deduct_boolean if @boolean.nil?

        @boolean
      end

      def scalar?
        @scalar = deduct_scalar if @scalar.nil?

        @scalar
      end

      def complex?
        !scalar?
      end

      def array?
        @array = deduct_array if @array.nil?

        @array
      end

      def initial_value
        return nil unless complex?
        return nil unless initialize?

        return @initialize.call if @initialize.is_a? Proc

        @klass.new
      end

      def create_methods(target_klass)
        if scalar?
          if readonly?
            create_readonly_scalar_reader target_klass
          else
            create_scalar_reader target_klass
            create_scalar_writer target_klass
            create_boolean_bang_writer target_klass if boolean?
          end

          create_boolean_question_mark_reader target_klass if boolean?
        else
          create_complex_reader target_klass
        end
      end

      private

      def deduct_array
        @klass <= Array
      end

      def deduct_boolean
        @klass == TrueClass || @klass == FalseClass
      end

      def deduct_scalar
        @klass.nil? || boolean? || @klass <= Numeric || @klass == String || @klass == Symbol
      end


      def create_readonly_scalar_reader(target_klass)
        variable = @variable

        target_klass.send :define_method, @name do
          instance_variable_get variable
        end
      end

      def create_boolean_question_mark_reader(target_klass)
        variable = @variable

        target_klass.send :define_method, "#{@string_name}?" do
          value = instance_variable_get variable

          !!value
        end
      end

      def create_scalar_reader(target_klass)
        variable = @variable

        target_klass.send :define_method, @name do |value = nil|
          return instance_variable_get variable if value.nil?

          instance_variable_set variable, value
        end
      end

      def create_scalar_writer(target_klass)
        variable = @variable

        target_klass.send :define_method, "#{@string_name}=" do |value|
          instance_variable_set variable, value
        end
      end

      def create_boolean_bang_writer(target_klass)
        variable = @variable

        target_klass.send :define_method, "#{@string_name}!" do
          instance_variable_set variable, true
        end
      end

      def create_complex_reader(target_klass)
        variable = @variable

        target_klass.send :define_method, @name do |&block|
          value = instance_variable_get variable

          value.instance_eval(&block) unless block.nil?

          value
        end
      end
    end
  end
end
