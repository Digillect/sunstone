require 'sunstone/objects/base_object'
require 'sunstone/objects/preferred_scheduling_term'
require 'sunstone/objects/node_selector'

module Sunstone
  module Objects
    class NodeAffinity < BaseObject
      property :preferred, readonly: true, serialized_name: 'preferredDuringSchedulingIgnoredDuringExecution'
      property :required, readonly: true, serialized_name: 'requiredDuringSchedulingIgnoredDuringExecution'

      def initialize
        super

        @preferred = []
        @required = NodeSelector.new
      end

      def empty?
        @preferred.empty? && @required.empty?
      end

      def add_preferred_term(&block)
        term = PreferredSchedulingTerm.new

        term.instance_eval(&block) if block_given?

        @preferred.push term

        term
      end
    end
  end
end
