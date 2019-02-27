require 'sunstone/objects/base_object'
require 'sunstone/objects/container_port'
require 'sunstone/objects/container_environment_helper'
require 'sunstone/objects/probe'
require 'sunstone/objects/volume_mount'

module Sunstone
  module Objects
    class Container < BaseObject
      property :name, readonly: true
      property :image
      property :image_pull_policy
      property :args, readonly: true
      property :command, readonly: true
      property :working_dir
      property :stdin, boolean: true
      property :stdin_once, boolean: true
      property :env, readonly: true
      property :env_from, readonly: true
      property :ports, readonly: true
      property :liveness_probe, readonly: true
      property :readiness_probe, readonly: true
      property :termination_message_path
      property :termination_message_policy
      property :tty, boolean: true
      property :volume_mounts, readonly: true

      def initialize(name)
        super()

        @args = []
        @command = []
        @env = []
        @env_from = []
        @name = name
        @ports = []
        @liveness_probe = Probe.new
        @readiness_probe = Probe.new
        @volume_mounts = []
      end

      def args(*args)
        return @args if args.empty?

        @args.concat args
      end

      def command(*command_parts)
        return @command if command_parts.empty?

        @command.concat command_parts
      end

      def expose_default_http_port
        @ports.push ContainerPort.new(80, name: 'http')
      end

      def environment(&block)
        @environment ||= ContainerEnvironmentHelper.new(@env, @env_from)

        @environment.instance_eval(&block) if block_given?

        @environment
      end

      def image(image = nil, image_pull_policy = nil)
        return @image unless image

        @image_pull_policy = image_pull_policy if image_pull_policy
        @image = image
      end

      def mount_volume(volume_name, mount_path, readonly: nil, mount_propagation: nil, sub_path: nil)
        @volume_mounts.push VolumeMount.new(volume_name, mount_path, readonly, mount_propagation, sub_path)
      end
    end
  end
end
