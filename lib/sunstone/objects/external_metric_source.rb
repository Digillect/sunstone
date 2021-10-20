module Sunstone
  module Objects
    class ExternalMetricSource < BaseObject
      property :metric, MetricIdentifier
      property :target, MetricTarget
    end
  end
end
