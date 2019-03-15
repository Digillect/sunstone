require 'sunstone/objects/base_object'
require 'sunstone/objects/node_selector_requirement_array'

module Sunstone
  module Objects
    class NodeSelectorTerm < BaseObject
      property :match_expressions, NodeSelectorRequirementArray
      property :match_fields, NodeSelectorRequirementArray
    end
  end
end
