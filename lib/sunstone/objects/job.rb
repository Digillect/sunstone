module Sunstone
  module Objects
    class Job < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      api_version 'batch/v1'

      property :spec, JobSpec

      def initialize(name)
        super

        pod_spec.restart_policy :OnFailure
      end
    end
  end
end
