require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/pod_spec'

module Sunstone
  module Objects
    class Pod < KubernetesObject
      property :spec, PodSpec

      def initialize(name)
        super
      end

      def api_version
        'v1'
      end

      alias pod_spec spec

      def container(name = :main, &block)
        @spec.container(name, &block)
      end

      def volumes(&block)
        @spec.volumes(&block)
      end
    end
  end
end
