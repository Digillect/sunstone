require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/stateful_set_spec'
require 'sunstone/objects/persistent_volume_claim'
require 'sunstone/objects/pod_template_extensions'
require 'sunstone/objects/pod_template_owner'

module Sunstone
  module Objects
    class StatefulSet < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      property :spec, StatefulSetSpec

      def initialize(name)
        super
      end

      def api_version
        'apps/v1'
      end

      def volume_claim(name, &block)
        claim = PersistentVolumeClaim.new(name)

        claim.instance_eval(block) if block_given?

        claim
      end
    end
  end
end
