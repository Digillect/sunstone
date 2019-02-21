require 'sunstone/objects/label_selector'
require 'sunstone/objects/pod_template_spec'

module Sunstone
  module Objects
    class JobSpec
      attr_accessor :active_deadline_seconds, :backoff_limit, :completions
      attr_accessor :manual_selector, :parallelism, :ttl_seconds_after_finished
      attr_reader :selector, :template

      def initialize
        @selector = LabelSelector.new
        @template = PodTemplateSpec.new
      end

      def to_hash
        result = {}

        result[:activeDeadlineSeconds] = @active_deadline_seconds if @active_deadline_seconds
        result[:backoffLimit] = @backoff_limit if @backoff_limit
        result[:completions] = @completions if @completions
        result[:manualSelector] = @manual_selector if @manual_selector
        result[:parallelism] = @parallelism if @parallelism
        result[:selector] = @selector.to_hash unless @selector.empty?
        result[:template] = @template.to_hash
        result[:ttlSecondsAfterFinished] = @ttl_seconds_after_finished if @ttl_seconds_after_finished

        result
      end
    end
  end
end
