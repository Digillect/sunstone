module Sunstone
  module Objects
    class CronJobBatchV1beta1 < KubernetesObject
      include PodTemplateExtensions

      api_version 'batch/v1beta1', 'CronJob'

      property :spec, CronJobSpec

      def initialize(name)
        super

        pod_spec.restart_policy :OnFailure
      end

      def pod_template
        yield spec.job_template.spec.template if block_given?

        spec.job_template.spec.template
      end

      def schedule(cron_schedule)
        spec.schedule = cron_schedule
      end
    end
  end
end
