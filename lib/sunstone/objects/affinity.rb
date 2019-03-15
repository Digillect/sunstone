require 'sunstone/objects/base_object'
require 'sunstone/objects/node_affinity'
require 'sunstone/objects/pod_affinity'
require 'sunstone/objects/pod_anti_affinity'

module Sunstone
  module Objects
    class Affinity < BaseObject
      property :node_affinity, NodeAffinity
      property :pod_affinity, PodAffinity
      property :pod_anti_affinity, PodAntiAffinity
    end
  end
end
