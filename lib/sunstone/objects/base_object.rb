require 'ostruct'

module Sunstone
  module Objects
    class BaseObject
      def initialize
        self.class.properties.each do |property|
          instance_variable_set(property.variable, nil)
        end
      end

      def to_hash
        result = {}

        pre_serialize_properties(result) if respond_to?(:pre_serialize_properties, true)

        serialize_properties(result)

        post_serialize_properties(result) if respond_to?(:post_serialize_properties, true)

        result
      end

      private

      def convert_property_value(value, serializer = nil, item_serializer = nil)
        return nil if value.nil?
        return nil if !value.is_a?(String) && value.respond_to?('empty?') && value.empty?

        if serializer
          serializer.call(self, value)
        elsif value.is_a? OpenStruct
          convert_property_value value.to_h, item_serializer
        elsif value.is_a? Hash
          if item_serializer
            value.transform_values { |item| item_serializer.call(item) }
          else
            value.transform_values(&method(:convert_property_value))
          end
        elsif value.respond_to? 'to_hash'
          value.to_hash
        elsif value.is_a? Enumerable
          if item_serializer
            value.map { |item| item_serializer.call(item) }
          else
            value.map(&method(:convert_property_value))
          end
        elsif value.is_a?(Numeric) || value.is_a?(TrueClass) || value.is_a?(FalseClass)
          value
        else
          value.to_s
        end
      end

      def serialize_properties(result)
        self.class.properties.each do |property|
          value = instance_variable_get(property.variable)

          value = convert_property_value(value, property.serializer, property.item_serializer)

          result[property.serialized_name] = value unless value.nil?
        end
      end

      def self.class_properties
        @properties ||= []
      end

      def self.properties
        result = []
        klass = self

        while klass.respond_to? 'class_properties'
          result << klass.class_properties

          klass = klass.superclass
        end

        result.reverse.flatten
      end

      def self.property(name, boolean: false, readonly: false, serialized_name: nil, serializer: nil, item_serializer: nil)
        name = name.to_sym
        string_name = name.to_s
        variable = "@#{string_name}".to_sym
        serialized_name ||= string_name.camelize(:lower)

        raise "Property #{string_name} is already defined in class #{self.name}" if properties.any? { |p| p.name == name }

        class_properties << OpenStruct.new(
          name: name,
          variable: variable,
          serialized_name: serialized_name.to_sym,
          serializer: serializer,
          item_serializer: item_serializer
        )

        if boolean
          define_method name do |value = nil|
            return instance_variable_get(variable) unless value

            instance_variable_set(variable, !!value)
          end

          define_method "#{string_name}?".to_sym do
            !!instance_variable_get(variable)
          end

          unless readonly
            define_method "#{string_name}=".to_sym do |value|
              instance_variable_set(variable, !!value)
            end

            define_method "#{string_name}!".to_sym do
              instance_variable_set(variable, true)
            end
          end
        elsif readonly
          define_method name do |&block|
            value = instance_variable_get(variable)

            value.instance_eval(&block) unless block.nil?

            value
          end
        else
          define_method name do |value = nil, &block|
            return instance_variable_get(variable) unless value

            value.instance_eval(&block) unless block.nil?

            instance_variable_set(variable, value)
          end

          define_method "#{string_name}=".to_sym do |value|
            instance_variable_set(variable, value)
          end
        end
      end
    end
  end
end
