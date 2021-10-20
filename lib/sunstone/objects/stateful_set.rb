module Sunstone
  module Objects
    class StatefulSet < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      property :spec, StatefulSetSpec

      def api_version
        'apps/v1'
      end

      def volume_claim(name, &block)
        claim = PersistentVolumeClaim.new(name)

        claim.instance_eval(&block) if block_given?

        claim
      end
    end
  end
end
