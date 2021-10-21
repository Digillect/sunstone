module Sunstone
  module Objects
    class Role < KubernetesObject
      api_version 'rbac.authorization.k8s.io/v1'

      property :rules, BaseArray, PolicyRule

      def add_rule(&block)
        rule = PolicyRule.new

        rule.instance_eval(&block) unless block.nil?

        @rules << rule

        rule
      end
    end
  end
end
