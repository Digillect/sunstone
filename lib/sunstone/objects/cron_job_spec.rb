require 'sunstone/objects/base_object'
require 'sunstone/objects/job_template_spec'

module Sunstone
  module Objects
    class CronJobSpec < BaseObject
      property :schedule
      property :failed_jobs_history_limit
      property :successful_jobs_history_limit
      property :concurrency_policy
      property :starting_deadline_seconds
      property :suspend, boolean: true
      property :job_template, readonly: true

      def initialize
        super

        @job_template = JobTemplateSpec.new
      end
    end
  end
end
