module Sunstone
  module Objects
    class RollingUpdateDaemonSet
      def initialize
        @max_unavailable = nil
      end

      def empty?
        @max_unavailable.nil?
      end

      def max_unavailable(value = nil)
        return @max_unavailable if value.nil?

        if value.is_a? Integer
          raise ArgumentError, "max_unavailable's value should be greater than zero" unless value.positive?
        elsif value.is_a? String
          valid = value.end_with? '%'

          if valid
            percentage = value.chomp '%'

            valid = /^\d+$/.match? percentage

            if valid
              percentage = percentage.to_i

              valid = percentage.positive? && percentage <= 100
            end
          end

          raise ArgumentError, "max_unavailable's value should be an integer between 1 and 100 and ends with a percent sign" unless valid
        else
          raise ArgumentError, 'max_unavailable value should be an absolute count or percentage'
        end

        @max_unavailable = value
      end

      def to_hash
        { maxUnavailable: @max_unavailable }
      end
    end
  end
end
