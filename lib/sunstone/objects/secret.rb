require 'base64'
require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/config_map_or_secret'

module Sunstone
  module Objects
    class Secret < KubernetesObject
      include ConfigMapOrSecret

      property :type
      property :data, readonly: true, item_serializer: ->(value) { Base64.strict_encode64(value ? value.to_s : '') }

      def initialize(name)
        super

        @data = {}
      end

      def api_version
        'v1'
      end
    end
  end
end

R.register_resource :secret, Sunstone::Objects::Secret
