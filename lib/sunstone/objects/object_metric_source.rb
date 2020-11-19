require 'sunstone/objects/base_object'
require 'sunstone/objects/cross_version_object_reference'
require 'sunstone/objects/metric_identifier'
require 'sunstone/objects/metric_target'

module Sunstone
  module Objects
    class ObjectMetricSource < BaseObject
      property :describedObject, CrossVersionObjectReference
      property :metric, MetricIdentifier
      property :target, MetricTarget
    end
  end
end
