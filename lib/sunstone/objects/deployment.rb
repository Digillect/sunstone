require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/deployment_spec'
require 'sunstone/objects/pod_template_owner'
require 'sunstone/objects/pod_template_extensions'

module Sunstone
  module Objects
    class Deployment < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      property :spec, DeploymentSpec

      def initialize(name)
        super
      end

      def api_version
        'apps/v1'
      end

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

R.register_resource :deployment, Sunstone::Objects::Deployment
