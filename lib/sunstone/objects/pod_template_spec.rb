require 'sunstone/objects/base_object'
require 'sunstone/objects/kubernetes_object_metadata'
require 'sunstone/objects/pod_spec'

module Sunstone
  module Objects
    class PodTemplateSpec < BaseObject
      property :metadata, KubernetesObjectMetadata
      property :spec, PodSpec
    end
  end
end
