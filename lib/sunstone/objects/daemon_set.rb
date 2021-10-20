module Sunstone
  module Objects
    class DaemonSet < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      property :spec, DaemonSetSpec

      def api_version
        'apps/v1'
      end
    end
  end
end
