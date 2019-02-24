require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/stateful_set_spec'
require 'sunstone/objects/pod_template_extensions'
require 'sunstone/objects/pod_template_owner'

module Sunstone
  module Objects
    class StatefulSet < KubernetesObject
      include PodTemplateOwner
      include PodTemplateExtensions

      attr_reader :spec

      def initialize(name)
        super

        @spec = StatefulSetSpec.new
      end

      def api_version
        'apps/v1'
      end

      def to_hash
        result = super

        result[:spec] = @spec.to_hash

        result
      end
    end
  end
end

R.register_resource :stateful_set, Sunstone::Objects::StatefulSet
