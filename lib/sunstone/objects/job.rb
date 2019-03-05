require 'sunstone/objects/pod_template_owner'
require 'sunstone/objects/pod_template_extensions'

module Sunstone
  module Objects
    class Job < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      property :spec, readonly: true

      def initialize(name)
        super

        @spec = JobSpec.new

        pod_template_spec.restart_policy :OnFailure
      end

      def api_version
        'batch/v1'
      end
    end
  end
end

R.register_resource :job, Sunstone::Objects::Job
