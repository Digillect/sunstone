module Sunstone
  module Objects
    class PodAffinity < BaseObject
      property :preferred, BaseArray, WeightedPodAffinityTerm, serialized_name: 'preferredDuringSchedulingIgnoredDuringExecution'
      property :required, BaseArray, PodAffinityTerm, serialized_name: 'requiredDuringSchedulingIgnoredDuringExecution'

      def add_preferred_term(&block)
        term = WeightedPodAffinityTerm.new

        term.instance_eval(&block) if block_given?

        @preferred << term

        term
      end

      def add_required_term(&block)
        term = PodAffinityTerm.new

        term.instance_eval(&block) if block_given?

        @required << term

        term
      end
    end
  end
end
