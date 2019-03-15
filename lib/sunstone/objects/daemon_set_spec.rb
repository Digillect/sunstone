require 'sunstone/objects/base_object'
require 'sunstone/objects/daemon_set_update_strategy'
require 'sunstone/objects/label_selector'
require 'sunstone/objects/pod_template_spec'

module Sunstone
  module Objects
    class DaemonSetSpec < BaseObject
      property :min_ready_seconds, Integer
      property :revision_history_limit, Integer
      property :selector, LabelSelector
      property :template, PodTemplateSpec
      property :update_strategy, DaemonSetUpdateStrategy
    end
  end
end
