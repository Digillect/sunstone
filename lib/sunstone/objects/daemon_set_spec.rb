require 'sunstone/objects/base_object'
require 'sunstone/objects/daemon_set_update_strategy'
require 'sunstone/objects/label_selector'
require 'sunstone/objects/pod_template_spec'

module Sunstone
  module Objects
    class DaemonSetSpec < BaseObject
      property :min_ready_seconds
      property :revision_history_limit
      property :selector, readonly: true
      property :template, readonly: true
      property :update_strategy, readonly: true

      def initialize
        super

        @selector = LabelSelector.new
        @template = PodTemplateSpec.new
        @update_strategy = DaemonSetUpdateStrategy.new
      end
    end
  end
end
