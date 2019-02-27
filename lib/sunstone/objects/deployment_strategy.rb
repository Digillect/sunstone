require 'sunstone/objects/rolling_update_deployment'

module Sunstone
  module Objects
    class DeploymentStrategy
      AVAILABLE_TYPES = %w[RollingUpdate Recreate].freeze

      def initialize
        @type = 'RollingUpdate'
        @rolling_update = RollingUpdateDeployment.new
      end

      def type(value = nil)
        return @type unless value

        value = value.to_s

        raise "Invalid Deployment strategy type '#{value}'" unless AVAILABLE_TYPES.include? value
        return if @type == value

        @type = value
      end

      def rolling_update(&block)
        @rolling_update.instance_eval(&block) if block_given?

        @rolling_update
      end

      def empty?
        return @rolling_update.empty? if @type == 'RollingUpdate'

        false
      end

      def to_hash
        result = { type: @type }

        result[:rollingUpdate] = @rolling_update.to_hash unless @rolling_update.blank?

        result
      end
    end
  end
end
