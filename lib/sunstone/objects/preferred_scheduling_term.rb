require 'sunstone/objects/base_object'
require 'sunstone/objects/node_selector_term'

module Sunstone
  module Objects
    class PreferredSchedulingTerm < BaseObject
      property :preference, readonly: true
      property :weight

      def initialize
        super

        @preference = NodeSelectorTerm.new
      end

      def empty?
        @preference.empty?
      end
    end
  end
end
