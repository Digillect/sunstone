module Sunstone
  module Objects
    class ObjectMetricSource < BaseObject
      property :describedObject, CrossVersionObjectReference
      property :metric, MetricIdentifier
      property :target, MetricTarget
    end
  end
end
