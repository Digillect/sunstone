module Sunstone
  module Objects
    class NodeSelectorTerm < BaseObject
      property :match_expressions, NodeSelectorRequirementArray
      property :match_fields, NodeSelectorRequirementArray
    end
  end
end
