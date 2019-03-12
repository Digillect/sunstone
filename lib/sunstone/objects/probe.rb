require 'sunstone/objects/actions_owner'

module Sunstone
  module Objects
    class Probe < BaseObject
      include ActionsOwner

      property :failure_threshold
      property :initial_delay_seconds
      property :period_seconds
      property :success_threshold
      property :timeout

      def empty?
        action_empty? && @failure_threshold.nil? && @initial_delay.nil? && @period.nil? && @success_threshold.nil? && @timeout.nil?
      end
    end
  end
end
