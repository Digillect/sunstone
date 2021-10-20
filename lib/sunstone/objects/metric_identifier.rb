module Sunstone
  module Objects
    class MetricIdentifier < BaseObject
      property :name, String
      property :selector, LabelSelector
    end
  end
end
