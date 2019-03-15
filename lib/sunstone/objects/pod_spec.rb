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
      property :active_deadline_seconds, Integer
      property :affinity, Affinity
      property :automount_service_account_token, TrueClass
      property :dns_config, PodDNSConfig
      property :dns_policy, String
      property :enable_service_links, TrueClass
      property :host_aliases, Array, HostAlias
      property :host_ipc, TrueClass, serialized_name: :hostIPC
      property :host_network, TrueClass
      property :host_pid, TrueClass, serialized_name: :hostPID
      property :hostname, String
      property :node_name, String
      property :node_selector, Hash
      property :priority, Integer
      property :priority_class_name, String
      property :readiness_gates, Array, PodReadinessGate
      property :restart_policy, String
      property :runtime_class_name, String
      property :security_context, PodSecurityContext
      property :scheduler_name, String
      property :service_account_name, String
      property :share_process_namespace, TrueClass
      property :subdomain, String
      property :termination_grace_period_seconds, Integer
      property :tolerations, Array, Toleration
      property :image_pull_secrets, Array, LocalObjectReference
      property :containers, Array, Container
      property :init_containers, Array, Container
      property :volumes, VolumeArray

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
