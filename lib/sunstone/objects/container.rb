require 'sunstone/objects/container_port'
require 'sunstone/objects/container_environment_helper'
require 'sunstone/objects/probe'
require 'sunstone/objects/volume_mount'

module Sunstone
  module Objects
    class Container
      attr_accessor :image_pull_policy
      attr_reader :args, :command, :env, :env_from, :name, :ports, :volume_mounts
      attr_writer :image

      def initialize(name)
        @args = []
        @command = []
        @env = []
        @env_from = []
        @name = name
        @ports = []
        @volume_mounts = []
      end

      def image(value = nil, pull_policy = nil)
        @image = value.to_s unless value.blank?
        @image_pull_policy = pull_policy unless pull_policy.blank?

        @image
      end

      def expose_default_http_port
        @ports.push ContainerPort.new(80, name: 'http')
      end

      def environment(&block)
        @environment ||= ContainerEnvironmentHelper.new(@env, @env_from)

        @environment.instance_eval(&block) if block_given?

        @environment
      end

      def mount_volume(volume_name, mount_path, readonly: nil, mount_propagation: nil, sub_path: nil)
        @volume_mounts.push VolumeMount.new(volume_name, mount_path, readonly, mount_propagation, sub_path)
      end

      def liveness_probe(&block)
        @liveness_probe ||= Probe.new

        @liveness_probe.instance_eval(&block) if block_given?

        @liveness_probe
      end

      def readiness_probe(&block)
        @readiness_probe ||= Probe.new

        @readiness_probe.instance_eval(&block) if block_given?

        @readiness_probe
      end

      def to_hash
        result = { name: name.to_s, image: image.to_s }

        result[:imagePullPolicy] = @image_pull_policy.to_s unless @image_pull_policy.blank?
        result[:args] = @args.flatten.map(&:to_s) unless @args.empty?
        result[:command] = @command.flatten.map(&:to_s) unless @command.empty?
        result[:env] = @env.map(&:to_hash) unless @env.empty?
        result[:envFrom] = @env_from.map(&:to_hash) unless @env_from.empty?
        result[:ports] = @ports.map(&:to_hash) unless @ports.empty?
        result[:livenessProbe] = @liveness_probe.to_hash unless @liveness_probe.blank?
        result[:readinessProbe] = @readiness_probe.to_hash unless @readiness_probe.blank?
        result[:volumeMounts] = @volume_mounts.map(&:to_hash) unless @volume_mounts.empty?

        result
      end
    end
  end
end
