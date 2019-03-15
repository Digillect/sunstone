require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class NodeSelectorRequirement < BaseObject
      property :key, String, readonly: true
      property :operator, String, readonly: true
      property :values, Array, initialize: false, test_emptiness: false

      def initialize(key, operator, values = nil)
        @key = key
        @operator = operator
        @values = values
      end

      def empty?
        @key.blank? && @operator.blank?
      end
    end
  end
end
