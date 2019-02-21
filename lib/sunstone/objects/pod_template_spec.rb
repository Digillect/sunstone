require 'sunstone/objects/kubernetes_object_metadata'
require 'sunstone/objects/pod_spec'

module Sunstone
  module Objects
    class PodTemplateSpec
      attr_reader :metadata, :spec

      def initialize
        @metadata = KubernetesObjectMetadata.new
        @spec = PodSpec.new
      end

      def to_hash
        result = {}

        result[:metadata] = @metadata.to_hash unless @metadata.empty?
        result[:spec] = @spec.to_hash

        result
      end
    end
  end
end
