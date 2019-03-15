require 'sunstone/objects/base_object'
require 'sunstone/objects/kubernetes_object_metadata'
require 'sunstone/objects/job_spec'

module Sunstone
  module Objects
    class JobTemplateSpec < BaseObject
      property :metadata, KubernetesObjectMetadata
      property :spec, JobSpec
    end
  end
end
