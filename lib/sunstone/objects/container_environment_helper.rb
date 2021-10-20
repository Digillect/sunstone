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
          add_or_replace_env_var name, value.to_s
        end
      end

      def add_config_map_key(name, config_map_name = nil, key: nil, optional: nil)
        add_or_replace_env_var name, EnvVarSource.new(ConfigMapKeySelector.new(key || name, config_map_name || @default_object_name, optional))
      end

      def add_secret_key(name, secret_name = nil, key: nil, optional: nil)
        add_or_replace_env_var name, EnvVarSource.new(SecretKeySelector.new(key || name, secret_name || @default_object_name, optional))
      end

      def add_field(name, field_path, api_version = nil)
        add_or_replace_env_var name, EnvVarSource.new(ObjectFieldSelector.new(field_path, api_version))
      end

      def add_resource_field(name, resource, container_name: nil, divisor: nil)
        add_or_replace_env_var name, EnvVarSource.new(ResourceFieldSelector.new(resource, container_name, divisor))
      end

      def use_config_map(name = nil, optional: nil, prefix: nil)
        add_env_from_source name, ConfigMapEnvSource, optional, prefix
      end

      def use_secret(name = nil, optional: nil, prefix: nil)
        add_env_from_source name, SecretEnvSource, optional, prefix
      end

      private

      def add_or_replace_env_var(name, value)
        @env.add_or_replace EnvVar.new(name, value), ->(v) { v.name == name }
      end

      def add_env_from_source(name, klass, optional, prefix)
        name ||= @default_object_name

        return if @env_from.any? { |s| s.source.class == klass && s.source.name == name }

        @env_from << EnvFromSource.new(klass.new(name, optional), prefix)
      end
    end
  end
end
