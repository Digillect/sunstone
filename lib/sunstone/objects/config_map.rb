require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/config_map_or_secret'

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

R.register_resource :config_map, Sunstone::Objects::ConfigMap
