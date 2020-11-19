require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class MetricTarget < BaseObject
      property :average_utilization, Integer
      property :average_value
      property :type, String
      property :value
    end
  end
end
