module Sunstone
  module Objects
    class JobTemplateSpec < BaseObject
      property :metadata, KubernetesObjectMetadata
      property :spec, JobSpec
    end
  end
end
