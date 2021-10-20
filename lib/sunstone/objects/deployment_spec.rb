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
