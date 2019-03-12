require 'sunstone/objects/base_object'
require 'sunstone/objects/affinity'
require 'sunstone/objects/container'
require 'sunstone/objects/host_alias'
require 'sunstone/objects/local_object_reference'
require 'sunstone/objects/pod_dns_config'
require 'sunstone/objects/pod_readiness_gate'
require 'sunstone/objects/pod_security_context'
require 'sunstone/objects/toleration'
require 'sunstone/objects/volume_array'

module Sunstone
  module Objects
    class PodSpec < BaseObject
      property :active_deadline_seconds
      property :affinity, readonly: true
      property :automount_service_account_token, boolean: true
      property :dns_config, readonly: true
      property :dns_policy
      property :enable_service_links, boolean: true
      property :host_aliases, readonly: true
      property :host_ipc, boolean: true, serialized_name: :hostIPC
      property :host_network, boolean: true
      property :host_pid, boolean: true, serialized_name: :hostPID
      property :hostname
      property :node_name
      property :node_selector
      property :priority
      property :priority_class_name
      property :readiness_gates, readonly: true
      property :restart_policy
      property :runtime_class_name
      property :security_context, readonly: true
      property :scheduler_name
      property :service_account_name
      property :share_process_namespace, boolean: true
      property :subdomain
      property :termination_grace_period_seconds
      property :tolerations, readonly: true
      property :image_pull_secrets, readonly: true
      property :containers, readonly: true
      property :init_containers, readonly: true
      property :volumes, readonly: true

      def initialize
        super

        @affinity = Affinity.new
        @dns_config = PodDNSConfig.new
        @host_aliases = []
        @image_pull_secrets = []
        @node_selector = {}
        @readiness_gates = []
        @security_context = PodSecurityContext.new
        @tolerations = []
        @containers = []
        @init_containers = []
        @volumes = VolumeArray.new
      end

      def container(name = :main, &block)
        container = @containers.find { |c| c.name == name }

        unless container
          container = Container.new name

          @containers.push container
        end

        container.instance_eval(&block) if block_given?

        container
      end

      def host_alias(ip, *host_names)
        @host_aliases.push HostAlias.new(ip, host_names)
      end

      def init_container(name, &block)
        container = @init_containers.find { |c| c.name == name }

        unless container
          container = Container.new name

          @init_containers.push container
        end

        container.instance_eval(&block) if block_given?

        container
      end

      def image_pull_secrets(*names)
        return @image_pull_secrets if names.empty?

        names.each do |name|
          @image_pull_secrets.push LocalObjectReference.new(name)
        end

        @image_pull_secrets
      end

      alias image_pull_secret image_pull_secrets

      def node_selector(labels = {})
        return @node_selector if labels.empty?

        @node_selector.merge! labels
      end

      def node_selector!(labels = {})
        return @node_selector if labels.empty?

        @node_selector = labels.dup
      end

      def readiness_gates(*gates)
        return @readiness_gates if gates.empty?

        gates.each do |gate|
          @readiness_gates.push PodReadinessGate.new(gate)
        end
      end

      alias readiness_gate readiness_gates

      def toleration(&block)
        toleration = Toleration.new

        toleration.instance_eval(&block) if block_given?

        @tolerations.push toleration

        toleration
      end
    end
  end
end
