require 'sunstone/objects/base_object'
require 'sunstone/objects/metric_identifier'
require 'sunstone/objects/metric_target'

module Sunstone
  module Objects
    class ExternalMetricSource < BaseObject
      property :metric, MetricIdentifier
      property :target, MetricTarget
    end
  end
end
