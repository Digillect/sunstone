module Sunstone
  module Objects
    class WeightedPodAffinityTerm < BaseObject
      property :pod_affinity_term, PodAffinityTerm
      property :weight, Integer
    end
  end
end

