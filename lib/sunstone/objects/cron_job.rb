require 'sunstone/objects/cron_job_spec'

require 'sunstone/objects/pod_template_extensions'

module Sunstone
  module Objects
    class CronJob < KubernetesObject
      include PodTemplateExtensions

      attr_reader :spec

      def initialize(name)
        super

        @spec = CronJobSpec.new
      end

      def api_version
        'batch/v1beta1'
      end

      def pod_template
        yield spec.job_template.spec.template if block_given?

        spec.job_template.spec.template
      end

      def schedule(cron_schedule)
        spec.schedule = cron_schedule
      end

      def to_hash
        result = super

        result[:spec] = @spec.to_hash

        result
      end
    end
  end
end

R.register_resource :cron_job, Sunstone::Objects::CronJob
