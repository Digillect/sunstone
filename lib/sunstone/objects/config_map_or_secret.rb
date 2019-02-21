require 'sunstone/objects/kubernetes_object'

module Sunstone
  module Objects
    class ConfigMapOrSecret < KubernetesObject
      def initialize(name)
        super

        @data = {}
      end

      def api_version
        'v1'
      end

      def set(keys_and_values)
        keys_and_values.each_pair do |key, value|
          @data[key] = value
        end

        self
      end

      def file(keys_and_paths)
        keys_and_paths.each_pair do |key, path|
          content = File.read path

          @data[key] = content
        end

        self
      end

      def to_hash
        result = super

        result[:data] = @data.transform_values(&method(:convert_value))

        result
      end

      protected

      def convert_value(value)
        value.to_s
      end
    end
  end
end
