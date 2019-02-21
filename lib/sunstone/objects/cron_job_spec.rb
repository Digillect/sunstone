require 'sunstone/objects/job_template_spec'

module Sunstone
  module Objects
    class CronJobSpec
      attr_accessor :concurrency_policy, :failed_jobs_history_limit, :schedule
      attr_accessor :starting_deadline_seconds, :successful_jobs_history_limit, :suspend
      attr_reader :job_template

      def initialize
        @job_template = JobTemplateSpec.new
      end

      def to_hash
        result = {}

        result[:schedule] = @schedule.to_s if @schedule
        result[:failedJobsHistoryLimit] = @failed_jobs_history_limit if @failed_jobs_history_limit
        result[:successfulJobsHistoryLimit] = @successful_jobs_history_limit if @successful_jobs_history_limit
        result[:concurrencyPolicy] = @concurrency_policy if @concurrency_policy
        result[:startingDeadlineSeconds] = @starting_deadline_seconds if @starting_deadline_seconds
        result[:suspend] = @suspend if @suspend
        result[:jobTemplate] = @job_template.to_hash

        result
      end
    end
  end
end
