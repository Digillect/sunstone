require 'sunstone/objects/base_object'
require 'sunstone/objects/label_selector'
require 'sunstone/objects/pod_template_spec'

module Sunstone
  module Objects
    class JobSpec < BaseObject
      property :active_deadline_seconds, Integer
      property :backoff_limit, Integer
      property :completions, Integer
      property :manual_selector, TrueClass
      property :parallelism, Integer
      property :ttl_seconds_after_finished, Integer
      property :selector, LabelSelector
      property :template, PodTemplateSpec
    end
  end
end
