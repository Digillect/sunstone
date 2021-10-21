module Sunstone
  module Objects
    class ConfigMap < KubernetesObject
      include ConfigMapOrSecret

      api_version 'v1'

      property :data, Hash, item_serializer: ->(value) { value.to_s }
    end
  end
end
