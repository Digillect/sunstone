require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/daemon_set_spec'
require 'sunstone/objects/pod_template_extensions'
require 'sunstone/objects/pod_template_owner'

module Sunstone
  module Objects
    class DaemonSet < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      property :spec, DaemonSetSpec

      def initialize(name)
        super
      end

      def api_version
        'apps/v1'
      end
    end
  end
end
