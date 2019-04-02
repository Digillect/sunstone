require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/aggregation_rule'
require 'sunstone/objects/policy_rule'

module Sunstone
  module Objects
    class ClusterRole < KubernetesObject
      property :aggregation_rule, AggregationRule
      property :rules, BaseArray, PolicyRule

      def api_version
        'rbac.authorization.k8s.io/v1'
      end

      def add_rule(&block)
        rule = PolicyRule.new

        rule.instance_eval(&block) unless block.nil?

        rule
      end
    end
  end
end
