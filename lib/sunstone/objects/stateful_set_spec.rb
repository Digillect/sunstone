require 'sunstone/objects/label_selector'
require 'sunstone/objects/pod_template_spec'
require 'sunstone/objects/stateful_set_update_strategy'

module Sunstone
  module Objects
    class StatefulSetSpec
      attr_accessor :pod_management_policy, :replicas, :revision_history_limit, :service_name
      attr_reader :selector, :template, :update_strategy, :volume_claim_templates

      def initialize
        @selector = LabelSelector.new
        @template = PodTemplateSpec.new
        @update_strategy = StatefulSetUpdateStrategy.new
        @volume_claim_templates = []
      end

      def to_hash
        result = {}

        result[:podManagementPolicy] = @pod_management_policy.to_s if @pod_management_policy
        result[:replicas] = @replicas if @replicas
        result[:revisionHistoryLimit] = @revision_history_limit if @revision_history_limit
        result[:serviceName] = @service_name.to_s if @service_name
        result[:selector] = @selector.to_hash unless @selector.empty?
        result[:template] = @template.to_hash
        result[:updateStrategy] = @update_strategy.to_hash unless @update_strategy.empty?
        result[:volumeClaimTemplates] = @volume_claim_templates.map(&:to_hash) unless @volume_claim_templates.empty?

        result
      end
    end
  end
end
