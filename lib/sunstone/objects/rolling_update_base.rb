module Sunstone
  module Objects
    class RollingUpdateBase

      protected

      def count_or_percentage(value, method_name)
        case value
        when Integer
          raise ArgumentError, "#{method_name}'s value should be greater than zero" unless value.positive?
        when String
          valid = value.end_with? '%'

          if valid
            percentage = value.chomp '%'

            valid = /^\d+$/.match? percentage

            if valid
              percentage = percentage.to_i

              valid = percentage.positive? && percentage <= 100
            end
          end

          raise ArgumentError, "#{method_name}'s value should be an integer between 1 and 100 and ends with a percent sign" unless valid
        else
          raise ArgumentError, "#{method_name} value should be an absolute count or percentage"
        end

        value
      end
    end
  end
end
