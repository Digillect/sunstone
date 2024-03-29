module Sunstone
  module Objects
    class Deployment < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      api_version 'apps/v1'

      property :spec, DeploymentSpec

      def match_labels(labels = {})
        labels = labels.transform_values(&:to_s)

        spec.selector.equals labels
        spec.template.metadata.labels.merge! labels
      end

      def replicas(number_of_replicas)
        spec.replicas = number_of_replicas if number_of_replicas
      end
    end
  end
end
