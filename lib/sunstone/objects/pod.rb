module Sunstone
  module Objects
    class Pod < KubernetesObject
      api_version 'v1'

      property :spec, PodSpec

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
