require 'sunstone/objects/base_object'
require 'sunstone/objects/node_selector_term'

module Sunstone
  module Objects
    class NodeSelector < BaseObject
      property :node_selector_terms, readonly: true

      def initialize
        super

        @node_selector_terms = []
      end

      def empty?
        @node_selector_terms.empty?
      end

      def add_term(&block)
        term = NodeSelectorTerm.new

        term.instance_eval(&block) if block_given?

        term
      end
    end
  end
end
