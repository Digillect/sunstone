require 'sunstone/objects/base_object'
require 'sunstone/objects/job_template_spec'

module Sunstone
  module Objects
    class CronJobSpec < BaseObject
      property :schedule, String
      property :failed_jobs_history_limit, Integer
      property :successful_jobs_history_limit, Integer
      property :concurrency_policy, String
      property :starting_deadline_seconds, Integer
      property :suspend, TrueClass
      property :job_template, JobTemplateSpec
    end
  end
end
