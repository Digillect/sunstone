module Sunstone
  module Objects
    class PodsMetricSource < BaseObject
      property :metric, MetricIdentifier
      property :target, MetricTarget
    end
  end
end
