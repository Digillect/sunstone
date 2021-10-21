module Sunstone
  module Objects
    class StatefulSet < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      api_version 'apps/v1'

      property :spec, StatefulSetSpec

      def volume_claim(name, &block)
        claim = PersistentVolumeClaim.new(name)

        claim.instance_eval(&block) if block_given?

        claim
      end
    end
  end
end
