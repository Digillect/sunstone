require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/daemon_set_spec'
require 'sunstone/objects/pod_template_extensions'
require 'sunstone/objects/pod_template_owner'

module Sunstone
  module Objects
    class DaemonSet < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      property :spec, readonly: true

      def initialize(name)
        super

        @spec = DaemonSetSpec.new
      end

      def api_version
        'apps/v1'
      end
    end
  end
end

R.register_resource :daemon_set, Sunstone::Objects::DaemonSet
