module Sunstone
  module Objects
    class PreferredSchedulingTerm < BaseObject
      property :preference, NodeSelectorTerm
      property :weight, Integer
    end
  end
end
