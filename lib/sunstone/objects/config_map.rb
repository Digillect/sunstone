module Sunstone
  module Objects
    class ConfigMap < KubernetesObject
      include ConfigMapOrSecret

      property :data, Hash, item_serializer: ->(value) { value.to_s }

      def initialize(name)
        super
      end

      def api_version
        'v1'
      end
    end
  end
end
