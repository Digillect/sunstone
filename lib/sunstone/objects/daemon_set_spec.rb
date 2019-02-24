require 'sunstone/objects/daemon_set_update_strategy'

module Sunstone
  module Objects
    class DaemonSetSpec
      attr_accessor :min_ready_seconds, :revision_history_limit
      attr_reader :selector, :template, :update_strategy

      def initialize
        @selector = LabelSelector.new
        @template = PodTemplateSpec.new
        @update_strategy = DaemonSetUpdateStrategy.new
      end

      def to_hash
        result = {}

        result[:minReadySeconds] = @min_ready_seconds if @min_ready_seconds
        result[:revisionHistoryLimit] = @revision_history_limit if @revision_history_limit
        result[:selector] = @selector.to_hash unless @selector.empty?
        result[:template] = @template.to_hash
        result[:updateStrategy] = @update_strategy unless @update_strategy.empty?

        result
      end
    end
  end
end
