require 'sunstone/objects/base_object'
require 'sunstone/objects/label_selector'

module Sunstone
  module Objects
    class MetricIdentifier < BaseObject
      property :name, String
      property :selector, LabelSelector
    end
  end
end
