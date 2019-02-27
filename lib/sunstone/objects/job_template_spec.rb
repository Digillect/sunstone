require 'sunstone/objects/base_object'
require 'sunstone/objects/kubernetes_object_metadata'
require 'sunstone/objects/job_spec'

module Sunstone
  module Objects
    class JobTemplateSpec < BaseObject
      property :metadata, readonly: true
      property :spec, readonly: true

      def initialize
        super

        @metadata = KubernetesObjectMetadata.new
        @spec = JobSpec.new
      end
    end
  end
end
