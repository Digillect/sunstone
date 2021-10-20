module Sunstone
  module Objects
    class NodeSelectorRequirementArray < BaseArray
      IN = 'In'.freeze
      NOT_IN = 'NotIn'.freeze
      EXISTS = 'Exists'.freeze
      DOES_NOT_EXISTS = 'DoesNotExists'.freeze
      GT = 'Gt'.freeze
      LT = 'Lt'.freeze

      def exists(key)
        self << NodeSelectorRequirement.new(key, EXISTS)
      end

      def does_not_exists(key)
        self << NodeSelectorRequirement.new(key, DOES_NOT_EXISTS)
      end

      def in(key, *values)
        raise ArgumentError, "Operator 'In' requires a list of values" if values.empty?

        self << NodeSelectorRequirement.new(key, IN, values)
      end

      def not_in(key, *values)
        raise ArgumentError, "Operator 'NotIn' requires a list of values" if values.empty?

        self << NodeSelectorRequirement.new(key, NOT_IN, values)
      end

      def less_than(key, value)
        raise ArgumentError, "Operator 'Lt' requires an Integer value" unless value.is_a? Integer

        self << NodeSelectorRequirement.new(key, LT, [value])
      end

      alias lt less_than

      def greater_than(key, value)
        raise ArgumentError, "Operator 'Gt' requires an Integer value" unless value.is_a? Integer

        self << NodeSelectorRequirement.new(key, GT, [value])
      end

      alias gt greater_than
    end
  end
end
