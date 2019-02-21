require 'sunstone/objects/label_selector'
require 'sunstone/objects/pod_template_spec'

module Sunstone
  module Objects
    class DeploymentSpec
      attr_accessor :min_ready_seconds, :paused, :progress_deadline_seconds, :revision_history_limit, :replicas
      attr_reader :selector, :template

      def initialize
        @selector = LabelSelector.new
        @template = PodTemplateSpec.new
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

        result
      end
    end
  end
end
