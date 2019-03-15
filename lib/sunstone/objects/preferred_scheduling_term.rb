require 'sunstone/objects/base_object'
require 'sunstone/objects/node_selector_term'

module Sunstone
  module Objects
    class PreferredSchedulingTerm < BaseObject
      property :preference, NodeSelectorTerm
      property :weight, Integer
    end
  end
end
