require 'sunstone/objects/base_object'
require 'sunstone/objects/container'
require 'sunstone/objects/local_object_reference_array'
require 'sunstone/objects/volume_array'

module Sunstone
  module Objects
    class PodSpec < BaseObject
      property :active_deadline_seconds
      property :automount_service_account_token, boolean: true
      property :dns_policy
      property :enable_service_links, boolean: true
      property :host_ipc, boolean: true, serialized_name: :hostIPC
      property :host_network, boolean: true
      property :host_pid, boolean: true, serialized_name: :hostPID
      property :hostname
      property :node_name
      property :priority
      property :priority_class_name
      property :restart_policy
      property :runtime_class_name
      property :scheduler_name
      property :service_account_name
      property :share_process_namespace, boolean: true
      property :subdomain
      property :termination_grace_period_seconds
      property :image_pull_secrets, readonly: true
      property :containers, readonly: true
      property :init_containers,readonly: true
      property :volumes, readonly: true

      def initialize
        super

        @image_pull_secrets = LocalObjectReferenceArray.new
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

      def init_container(name, &block)
        container = @init_containers.find { |c| c.name == name }

        unless container
          container = Container.new name

          @init_containers.push container
        end

        container.instance_eval(&block) if block_given?

        container
      end
    end
  end
end
