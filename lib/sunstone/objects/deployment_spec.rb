require 'sunstone/objects/label_selector'
require 'sunstone/objects/pod_template_spec'
require 'sunstone/objects/deployment_strategy'

module Sunstone
  module Objects
    class DeploymentSpec
      attr_accessor :min_ready_seconds, :paused, :progress_deadline_seconds, :revision_history_limit, :replicas
      attr_reader :selector, :template, :strategy

      def initialize
        @selector = LabelSelector.new
        @template = PodTemplateSpec.new
        @strategy = DeploymentStrategy.new
      end

      def to_hash
        result = {}

        result[:minReadySeconds] = @min_ready_seconds if @min_ready_seconds
        result[:paused] = @paused if @paused
        result[:progressDeadlineSeconds] = @progress_deadline_seconds if @progress_deadline_seconds
        result[:replicas] = @replicas if @replicas
        result[:revisionHistoryLimit] = @revision_history_limit if @revision_history_limit
        result[:selector] = @selector.to_hash unless @selector.empty?
        result[:template] = @template.to_hash
        result[:strategy] = @strategy.to_hash unless @strategy.empty?

        result
      end
    end
  end
end
