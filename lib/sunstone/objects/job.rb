require 'sunstone/objects/pod_template_owner'
require 'sunstone/objects/pod_template_extensions'

module Sunstone
  module Objects
    class Job < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      attr_reader :spec

      def initialize(name)
        super

        @spec = JobSpec.new
      end

      def api_version
        'batch/v1'
      end

      def to_hash
        result = super

        result[:spec] = @spec.to_hash

        result
      end
    end
  end
end

R.register_resource :job, Sunstone::Objects::Job
