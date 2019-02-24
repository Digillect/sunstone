module Sunstone
  module Objects
    class RollingUpdateStatefulSetStrategy
      def initialize
        @partition = nil
      end

      def partition(value = nil)
        return @partition unless value

        raise ArgumentError, 'Value must be an integer' unless value.is_a? Integer

        @partition = value
      end

      def empty?
        @partition.nil?
      end

      def to_hash
        { partition: @partition }
      end
    end
  end
end
