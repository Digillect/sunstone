require 'sunstone/objects/base_object'
require 'sunstone/objects/label_selector'
require 'sunstone/objects/pod_template_spec'
require 'sunstone/objects/deployment_strategy'

module Sunstone
  module Objects
    class DeploymentSpec < BaseObject
      property :replicas, Integer
      property :revision_history_limit, Integer
      property :min_ready_seconds, Integer
      property :progress_deadline_seconds, Integer
      property :paused, TrueClass
      property :selector, LabelSelector
      property :strategy, DeploymentStrategy
      property :template, PodTemplateSpec
    end
  end
end
