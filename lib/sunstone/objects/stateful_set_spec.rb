require 'sunstone/objects/base_object'
require 'sunstone/objects/label_selector'
require 'sunstone/objects/pod_template_spec'
require 'sunstone/objects/stateful_set_update_strategy'

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
      property :volume_claim_templates, Array, PersistentVolumeClaim
    end
  end
end
