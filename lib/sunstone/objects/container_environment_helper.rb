require 'sunstone/objects/env_var'
require 'sunstone/objects/env_from_source'
require 'sunstone/objects/config_map_key_selector'
require 'sunstone/objects/secret_key_selector'
require 'sunstone/objects/object_field_selector'
require 'sunstone/objects/resource_field_selector'
require 'sunstone/objects/config_map_env_source'
require 'sunstone/objects/secret_env_source'

module Sunstone
  module Objects
    class ContainerEnvironmentHelper
      def initialize(env, env_from, default_object_name)
        @default_object_name = default_object_name
        @env = env
        @env_from = env_from
      end

      def add(names_and_values = {})
        names_and_values.each do |name, value|
          @env << EnvVar.new(name, value.to_s)
        end
      end

      def add_config_map_key(name, config_map_name = nil, key: nil, optional: nil)
        @env << EnvVar.new(name, EnvVarSource.new(ConfigMapKeySelector.new(key || name, config_map_name || @default_object_name, optional)))
      end

      def add_secret_key(name, secret_name = nil, key: nil, optional: nil)
        @env << EnvVar.new(name, EnvVarSource.new(SecretKeySelector.new(key || name, secret_name || @default_object_name, optional)))
      end

      def add_field(name, field_path, api_version = nil)
        @env << EnvVar.new(name, EnvVarSource.new(ObjectFieldSelector.new(field_path, api_version)))
      end

      def add_resource_field(name, resource, container_name: nil, divisor: nil)
        @env << EnvVar.new(name, EnvVarSource.new(ResourceFieldSelector.new(resource, container_name, divisor)))
      end

      def use_config_map(name = nil, optional: nil, prefix: nil)
        @env_from << EnvFromSource.new(ConfigMapEnvSource.new(name || @default_object_name, optional), prefix)
      end

      def use_secret(name = nil, optional: nil, prefix: nil)
        @env_from << EnvFromSource.new(SecretEnvSource.new(name || @default_object_name, optional), prefix)
      end
    end
  end
end
