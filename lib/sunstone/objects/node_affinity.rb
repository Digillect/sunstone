module Sunstone
  module Objects
    class NodeAffinity < BaseObject
      property :preferred, BaseArray, PreferredSchedulingTerm, serialized_name: 'preferredDuringSchedulingIgnoredDuringExecution'
      property :required, NodeSelector, serialized_name: 'requiredDuringSchedulingIgnoredDuringExecution'

      def add_preferred_term(&block)
        term = PreferredSchedulingTerm.new

        term.instance_eval(&block) if block_given?

        @preferred << term

        term
      end
    end
  end
end
