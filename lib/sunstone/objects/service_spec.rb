require 'sunstone/objects/base_object'
require 'sunstone/objects/session_affinity_config'
require 'sunstone/objects/service_port'

module Sunstone
  module Objects
    class ServiceSpec < BaseObject
      property :type, String
      property :cluster_ip, String, serialized_name: :clusterIP
      property :external_ips, Array, String, serialized_name: :externalIPs
      property :external_name, String
      property :external_traffic_policy, String
      property :health_check_node_port, Integer
      property :load_balancer_ip, String, serialized_name: :loadBalancerIP
      property :load_balancer_source_ranges, Array, String
      property :ports, BaseArray, ServicePort
      property :publish_not_ready_addresses, TrueClass
      property :selector, Hash
      property :session_affinity, String
      property :session_affinity_config, SessionAffinityConfig

      def add_port(port, name: nil, node_port: nil, protocol: nil, target_port: nil, &block)
        port = ServicePort.new(port, name, node_port, protocol, target_port)

        port.instance_eval(&block) if block_given?

        @ports << port
      end
    end
  end
end
