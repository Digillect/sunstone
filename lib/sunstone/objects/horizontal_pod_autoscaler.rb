module Sunstone
  module Objects
    class HorizontalPodAutoscaler < KubernetesObject
      property :spec, HorizontalPodAutoscalerSpec

      def initialize(name)
        super
      end

      def api_version
        'autoscaling/v2beta2'
      end

      def scale_deployment(name, &block)
        spec.scale_target_ref.api_version 'apps/v1'
        spec.scale_target_ref.kind 'Deployment'
        spec.scale_target_ref.name name

        spec(&block) if block_given?
      end
    end
  end
end
