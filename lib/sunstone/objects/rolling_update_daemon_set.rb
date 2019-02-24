require 'sunstone/objects/rolling_update_base'

module Sunstone
  module Objects
    class RollingUpdateDaemonSet < RollingUpdateBase
      def initialize
        @max_unavailable = nil
      end

      def empty?
        @max_unavailable.nil?
      end

      def max_unavailable(value = nil)
        return @max_unavailable if value.nil?

        @max_unavailable = count_or_percentage value, 'max_unavailable'
      end

      def to_hash
        { maxUnavailable: @max_unavailable }
      end
    end
  end
end
