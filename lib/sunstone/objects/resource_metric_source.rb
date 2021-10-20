module Sunstone
  module Objects
    class ResourceMetricSource < BaseObject
      property :name, String
      property :target, MetricTarget
    end
  end
end
