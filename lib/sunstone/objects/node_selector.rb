module Sunstone
  module Objects
    class NodeSelector < BaseObject
      property :node_selector_terms, BaseArray, NodeSelectorTerm

      def add_term(&block)
        term = NodeSelectorTerm.new

        term.instance_eval(&block) if block_given?

        term
      end
    end
  end
end
