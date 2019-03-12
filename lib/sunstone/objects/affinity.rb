require 'sunstone/objects/base_object'
require 'sunstone/objects/node_affinity'
require 'sunstone/objects/pod_affinity'
require 'sunstone/objects/pod_anti_affinity'

module Sunstone
  module Objects
    class Affinity < BaseObject
      property :node_affinity, readonly: true
      property :pod_affinity, readonly: true
      property :pod_anti_affinity, readonly: true

      def initialize
        super

        @node_affinity = NodeAffinity.new
        @pod_affinity = PodAffinity.new
        @pod_anti_affinity = PodAntiAffinity.new
      end

      def empty?
        @node_affinity.empty? && @pod_affinity.empty? && @pod_anti_affinity.empty?
      end
    end
  end
end
