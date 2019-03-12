require 'sunstone/objects/base_object'
require 'sunstone/objects/pod_affinity_term'

module Sunstone
  module Objects
    class WeightedPodAffinityTerm < BaseObject
      property :pod_affinity_term, readonly: true
      property :weight

      def initialize
        super

        @pod_affinity_term = PodAffinityTerm.new
      end

      def empty?
        @pod_affinity_term.empty? && @weight.nil?
      end
    end
  end
end

