require 'sunstone/objects/base_object'
require 'sunstone/objects/label_selector'
require 'sunstone/objects/pod_template_spec'
require 'sunstone/objects/deployment_strategy'

module Sunstone
  module Objects
    class DeploymentSpec < BaseObject
      property :min_ready_seconds
      property :paused, boolean: true
      property :progress_deadline_seconds
      property :revision_history_limit
      property :replicas
      property :selector, readonly: true
      property :template, readonly: true
      property :strategy, readonly: true

      def initialize
        super

        @selector = LabelSelector.new
        @template = PodTemplateSpec.new
        @strategy = DeploymentStrategy.new
      end
    end
  end
end
