require 'sunstone/objects/base_object'
require 'sunstone/objects/node_selector_requirement_array'

module Sunstone
  module Objects
    class NodeSelectorTerm < BaseObject
      property :match_expressions, readonly: true
      property :match_fields, readonly: true

      def initialize
        super

        @match_expressions = NodeSelectorRequirementArray.new
        @match_fields = NodeSelectorRequirementArray.new
      end

      def empty?
        @match_expressions.empty? && @match_fields.empty?
      end
    end
  end
end
