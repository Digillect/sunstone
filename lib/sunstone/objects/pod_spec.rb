require 'sunstone/objects/container'
require 'sunstone/objects/local_object_reference_array'
require 'sunstone/objects/volume_array'

module Sunstone
  module Objects
    class PodSpec
      attr_accessor :active_deadline_seconds, :automount_service_account_token, :dns_policy, :service_account_name, :restart_policy
      attr_reader :containers, :image_pull_secrets, :init_containers, :volumes

      def initialize
        @containers = []
        @image_pull_secrets = LocalObjectReferenceArray.new
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

      def to_hash
        result = {}

        result[:activeDeadlineSeconds] = @active_deadline_seconds if @active_deadline_seconds
        result[:automountServiceAccountToken] = @automount_service_account_token if @automount_service_account_token
        result[:dnsPolicy] = @dns_policy if @dns_policy
        result[:restartPolicy] = @restart_policy.to_s if @restart_policy
        result[:imagePullSecrets] = @image_pull_secrets.map(&:to_hash) unless @image_pull_secrets.empty?
        result[:serviceAccountName] = @service_account_name unless @service_account_name.blank?
        result[:containers] = @containers.map(&:to_hash)
        result[:initContainers] = @init_containers.map(&:to_hash) unless @init_containers.empty?
        result[:volumes] = @volumes.map(&:to_hash) unless @volumes.empty?

        result
      end
    end
  end
end
