require 'sunstone/objects/base_object'
require 'sunstone/objects/container_port'
require 'sunstone/objects/container_environment_helper'
require 'sunstone/objects/lifecycle'
require 'sunstone/objects/probe'
require 'sunstone/objects/resource_requirements'
require 'sunstone/objects/security_context'
require 'sunstone/objects/volume_device'
require 'sunstone/objects/volume_mount'

module Sunstone
  module Objects
    class Container < BaseObject
      property :name, String, readonly: true
      property :args, Array, String
      property :command, Array, String
      property :working_dir, String
      property :image, String
      property :image_pull_policy, String
      property :env, BaseArray, EnvVar
      property :env_from, BaseArray, EnvFromSource
      property :liveness_probe, Probe
      property :readiness_probe, Probe
      property :lifecycle, Lifecycle
      property :resources, ResourceRequirements
      property :stdin, TrueClass
      property :stdin_once, TrueClass
      property :ports, BaseArray, ContainerPort
      property :security_context, SecurityContext
      property :termination_message_path, String
      property :termination_message_policy, String
      property :tty, TrueClass
      property :volume_devices, BaseArray, VolumeDevice
      property :volume_mounts, BaseArray, VolumeMount

      def initialize(name)
        super()

        @name = name
      end

      def args(*args)
        return @args if args.empty?

        @args.concat args
      end

      def command(*command_parts)
        return @command if command_parts.empty?

        @command.concat command_parts
      end

      def expose_port(container_port, host_ip: nil, host_port: nil, name: nil, protocol: nil, &block)
        port = ContainerPort.new(container_port, host_ip: host_ip, host_port: host_port, name: name, protocol: protocol)

        port.instance_eval(&block) unless block.nil?

        @ports << port
      end

      def expose_default_http_port(&block)
        expose_port 80, name: 'http', &block
      end

      def environment(&block)
        @environment ||= ContainerEnvironmentHelper.new(@env, @env_from, __root.metadata.name)

        @environment.instance_eval(&block) if block_given?

        @environment
      end

      def image(image = nil, image_pull_policy = nil)
        return @image unless image

        @image_pull_policy = image_pull_policy if image_pull_policy
        @image = image
      end

      def mount_device(volume_name, device_path)
        @volume_devices << VolumeDevice.new(volume_name, device_path)
      end

      def mount_volume(volume_name, mount_path, readonly: nil, mount_propagation: nil, sub_path: nil)
        @volume_mounts << VolumeMount.new(volume_name, mount_path, readonly, mount_propagation, sub_path)
      end
    end
  end
end
