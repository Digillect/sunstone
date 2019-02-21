require 'sunstone/objects/config_map_env_source'
require 'sunstone/objects/secret_env_source'

module Sunstone
  module Objects
    class EnvFromSource
      attr_reader :source, :prefix

      def initialize(source, prefix = nil)
        @source = source
        @prefix = prefix
      end

      def to_hash
        result = {}

        result[hash_key] = @source.to_hash
        result[:prefix] = @prefix unless @prefix.blank?

        result
      end

      private

      def hash_key
        case @source
        when ConfigMapEnvSource
          :configMapRef
        when SecretEnvSource
          :secretRef
        else
          raise 'Invalid EnvFromSource'
        end
      end
    end
  end
end
