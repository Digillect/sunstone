require 'sunstone/objects/rolling_update_base'

module Sunstone
  module Objects
    class RollingUpdateDeployment < RollingUpdateBase
      def initialize
        @max_surge = nil
        @max_unavailable = nil
      end

      def empty?
        @max_surge.nil? && @max_unavailable.nil?
      end

      def max_surge(value = nil)
        return @max_surge if value.nil?

        @max_surge = count_or_percentage value, 'max_surge'
      end

      def max_unavailable(value = nil)
        return @max_unavailable if value.nil?

        @max_unavailable = count_or_percentage value, 'max_unavailable'
      end

      def to_hash
        result = {}

        result[:maxSurge] = @max_surge if @max_surge
        result[:maxUnavailable] = @max_unavailable if @max_unavailable

        result
      end
    end
  end
end
