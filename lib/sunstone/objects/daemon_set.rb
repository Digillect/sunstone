module Sunstone
  module Objects
    class DaemonSet < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      api_version 'apps/v1'

      property :spec, DaemonSetSpec
    end
  end
end
