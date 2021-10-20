module Sunstone
  module Objects
    class StatefulSetSpec < BaseObject
      property :pod_management_policy, String
      property :replicas, Integer
      property :revision_history_limit, Integer
      property :service_name, String
      property :selector, LabelSelector
      property :template, PodTemplateSpec
      property :update_strategy, StatefulSetUpdateStrategy
      property :volume_claim_templates, BaseArray, PersistentVolumeClaim
    end
  end
end
