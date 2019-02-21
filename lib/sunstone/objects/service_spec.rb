require 'sunstone/objects/session_affinity_config'
require 'sunstone/objects/service_port'

module Sunstone
  module Objects
    class ServiceSpec
      attr_reader :external_ips, :load_balancer_source_ranges, :ports, :selector, :session_affinity_config

      attr_accessor :type, :cluster_ip, :external_name, :external_traffic_policy
      attr_accessor :health_check_node_port, :load_balancer_ip, :publish_not_ready_addresses
      attr_accessor :session_affinity

      def initialize
        @external_ips = []
        @load_balancer_source_ranges = []
        @ports = []
        @selector = {}
        @session_affinity_config = SessionAffinityConfig.new
      end

      def add_port(port, name: nil, node_port: nil, protocol: nil, target_port: nil)
        @ports.push ServicePort.new(port, name, node_port, protocol, target_port)
      end

      def to_hash
        result = {}

        result[:type] = @type.to_s unless @type.blank?
        result[:externalIPs] = @external_ips.map(&:to_s) unless @external_ips.empty?
        result[:externalName] = @external_name.to_s unless @external_name.blank?
        result[:externalTrafficPolicy] = @external_traffic_policy.to_s unless @external_traffic_policy.blank?
        result[:healthCheckNodePort] = @health_check_node_port unless @health_check_node_port.blank?
        result[:loadBalancerIP] = @load_balancer_ip.to_s unless @load_balancer_ip.blank?
        result[:loadBalancerSourceRanges] = @load_balancer_source_ranges.map(&:to_s) unless @load_balancer_source_ranges.empty?
        result[:ports] = @ports.map(&:to_hash) unless @ports.empty?
        result[:publishNotReadyAddresses] = !!@publish_not_ready_addresses unless @publish_not_ready_addresses.nil?
        result[:selector] = @selector.transform_values(&:to_s) unless @selector.empty?
        result[:sessionAffinity] = @session_affinity.to_s unless @session_affinity.blank?
        result[:sessionAffinityConfig] = @session_affinity_config.to_hash unless @session_affinity_config.empty?

        result
      end
    end
  end
end
