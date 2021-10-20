module Sunstone
  module Objects
    class PodTemplateSpec < BaseObject
      property :metadata, KubernetesObjectMetadata
      property :spec, PodSpec
    end
  end
end
