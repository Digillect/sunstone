require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class NodeSelectorRequirement < BaseObject
      property :key, readonly: true
      property :operator, readonly: true
      property :values, readonly: true

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
