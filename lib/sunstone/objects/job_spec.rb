require 'sunstone/objects/base_object'
require 'sunstone/objects/label_selector'
require 'sunstone/objects/pod_template_spec'

module Sunstone
  module Objects
    class JobSpec < BaseObject
      property :active_deadline_seconds
      property :backoff_limit
      property :completions
      property :manual_selector
      property :parallelism
      property :ttl_seconds_after_finished
      property :selector, readonly: true
      property :template, readonly: true

      def initialize
        super

        @selector = LabelSelector.new
        @template = PodTemplateSpec.new
      end
    end
  end
end
