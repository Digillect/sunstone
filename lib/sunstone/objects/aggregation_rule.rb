require 'sunstone/objects/base_object'
require 'sunstone/objects/label_selector'

module Sunstone
  module Objects
    class AggregationRule < BaseObject
      property :cluster_role_selectors, BaseArray, LabelSelector
    end
  end
end
