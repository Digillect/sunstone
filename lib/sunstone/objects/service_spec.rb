require 'sunstone/objects/base_object'
require 'sunstone/objects/session_affinity_config'
require 'sunstone/objects/service_port'

module Sunstone
  module Objects
    class ServiceSpec < BaseObject
      property :type
      property :cluster_ip, serialized_name: :clusterIP
      property :external_ips, readonly: true, serialized_name: :externalIPs
      property :external_name
      property :external_traffic_policy
      property :health_check_node_port
      property :load_balancer_ip, serialized_name: :loadBalancerIP
      property :load_balancer_source_ranges, readonly: true
      property :ports, readonly: true
      property :publish_not_ready_addresses, boolean: true
      property :selector, readonly: true
      property :session_affinity
      property :session_affinity_config, readonly: true

      def initialize
        super

        @external_ips = []
        @load_balancer_source_ranges = []
        @ports = []
        @selector = {}
        @session_affinity_config = SessionAffinityConfig.new
      end

      def add_port(port, name: nil, node_port: nil, protocol: nil, target_port: nil)
        @ports.push ServicePort.new(port, name, node_port, protocol, target_port)
      end
    end
  end
end
