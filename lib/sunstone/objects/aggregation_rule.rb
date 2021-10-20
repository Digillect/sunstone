module Sunstone
  module Objects
    class AggregationRule < BaseObject
      property :cluster_role_selectors, BaseArray, LabelSelector
    end
  end
end
