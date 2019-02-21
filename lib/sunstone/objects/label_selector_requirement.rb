module Sunstone
  module Objects
    class LabelSelectorRequirement
      IN = :In
      NOT_IN = :NotIn
      EXISTS = :Exists
      DOES_NOT_EXISTS = :DoesNotExists

      attr_reader :key, :operator, :values

      def initialize(key, operator, values = nil)
        @key = key
        @operator = operator
        @values = values.freeze
      end

      def to_hash
        result = { key: @key.to_s, operator: @operator.to_s }

        result[:values] = @values.map(&:to_s) if @operator == IN || @operator == NOT_IN

        result
      end
    end
  end
end
