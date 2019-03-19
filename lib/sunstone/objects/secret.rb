require 'base64'
require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/config_map_or_secret'

module Sunstone
  module Objects
    class Secret < KubernetesObject
      include ConfigMapOrSecret

      property :type, String
      property :data, Hash, item_serializer: ->(value) { Base64.strict_encode64(value ? value.to_s : '') }

      def initialize(name)
        super
      end

      def api_version
        'v1'
      end
    end
  end
end
