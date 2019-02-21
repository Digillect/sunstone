require 'sunstone/objects/kubernetes_object_metadata'
require 'sunstone/objects/job_spec'

module Sunstone
  module Objects
    class JobTemplateSpec
      attr_reader :metadata, :spec

      def initialize
        @metadata = KubernetesObjectMetadata.new
        @spec = JobSpec.new
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
