require 'sunstone/objects/base_object'
require 'sunstone/objects/label_selector'
require 'sunstone/objects/pod_template_spec'
require 'sunstone/objects/stateful_set_update_strategy'

module Sunstone
  module Objects
    class StatefulSetSpec < BaseObject
      property :pod_management_policy
      property :replicas
      property :revision_history_limit
      property :service_name
      property :selector, readonly: true
      property :template, readonly: true
      property :update_strategy, readonly: true
      property :volume_claim_templates, readonly: true

      def initialize
        super

        @selector = LabelSelector.new
        @template = PodTemplateSpec.new
        @update_strategy = StatefulSetUpdateStrategy.new
        @volume_claim_templates = []
      end
    end
  end
end
