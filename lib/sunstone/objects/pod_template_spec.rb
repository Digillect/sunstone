require 'sunstone/objects/base_object'
require 'sunstone/objects/kubernetes_object_metadata'
require 'sunstone/objects/pod_spec'

module Sunstone
  module Objects
    class PodTemplateSpec < BaseObject
      property :metadata, readonly: true
      property :spec, readonly: true

      def initialize
        super

        @metadata = KubernetesObjectMetadata.new
        @spec = PodSpec.new
      end
    end
  end
end
