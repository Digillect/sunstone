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
