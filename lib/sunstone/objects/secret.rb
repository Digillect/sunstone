require 'base64'

module Sunstone
  module Objects
    class Secret < KubernetesObject
      include ConfigMapOrSecret

      api_version 'v1'

      property :type, String
      property :data, Hash, item_serializer: ->(value) { Base64.strict_encode64(value ? value.to_s : '') }
    end
  end
end
