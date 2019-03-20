require 'sunstone/objects/base_array'
require 'sunstone/objects/parentable'
require 'sunstone/objects/property'

module Sunstone
  module Objects
    class BaseObject
      include Parentable

      def initialize
        self.class.properties.each do |property|
          value = property.initial_value

          value.__parent = self if value.is_a? Parentable

          instance_variable_set(property.variable, value)
        end
      end

      def empty?
        if respond_to?(:extra_properties_empty?, true)
          return false unless extra_properties_empty?
        end

        self.class.properties.each do |property|
          next unless property.test_emptiness?

          value = instance_variable_get property.variable

          next if value_is_empty? value

          return false
        end

        true
      end

      def to_hash
        result = {}

        pre_serialize_properties(result) if respond_to?(:pre_serialize_properties, true)

        serialize_properties(result)

        post_serialize_properties(result) if respond_to?(:post_serialize_properties, true)

        result
      end

      private

      def value_is_empty?(value)
        return true if value.nil?
        # return true if !value.is_a?(String) && value.respond_to?('empty?') && value.empty?
        return true if value.respond_to?('empty?') && value.empty?

        false
      end

      def convert_property_value(value, serializer = nil, item_serializer = nil)
        return nil if value_is_empty? value

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

      def self.property(
        name,
          klass = nil, item_klass = nil,
          readonly: false, initialize: nil, test_emptiness: true,
          serialized_name: nil,
          serializer: nil, item_serializer: nil)
        prop = Property.new(
          name,
          klass, item_klass,
          serialized_name: serialized_name,
          initialize: initialize, test_emptiness: test_emptiness, readonly: readonly
        )

        raise "Property #{prop.string_name} is already defined in class #{self.name}" if properties.any? { |p| p.name == prop.name }

        prop.serializer = serializer
        prop.item_serializer = item_serializer

        class_properties << prop

        prop.create_methods self
      end
    end
  end
end
