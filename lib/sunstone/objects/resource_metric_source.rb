require 'sunstone/objects/base_object'
require 'sunstone/objects/metric_target'

module Sunstone
  module Objects
    class ResourceMetricSource < BaseObject
      property :name, String
      property :target, MetricTarget
    end
  end
end
