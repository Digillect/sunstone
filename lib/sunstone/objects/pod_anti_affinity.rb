require 'sunstone/objects/base_object'
require 'sunstone/objects/weighted_pod_affinity_term'
require 'sunstone/objects/pod_affinity_term'

module Sunstone
  module Objects
    class PodAntiAffinity < BaseObject
      property :preferred, Array, WeightedPodAffinityTerm, serialized_name: 'preferredDuringSchedulingIgnoredDuringExecution'
      property :required, Array, PodAffinityTerm, serialized_name: 'requiredDuringSchedulingIgnoredDuringExecution'

      def add_preferred_term(&block)
        term = WeightedPodAffinityTerm.new

        term.instance_eval(&block) if block_given?

        @preferred.push term

        term
      end

      def add_required_term(&block)
        term = PodAffinityTerm.new

        term.instance_eval(&block) if block_given?

        @preferred.push term

        term
      end
    end
  end
end
