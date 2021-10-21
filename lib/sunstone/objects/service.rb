module Sunstone
  module Objects
    class Service < KubernetesObject
      api_version 'v1'

      property :spec, ServiceSpec

      def match_labels(labels = {})
        @spec.selector.merge! labels
      end

      def expose_default_http_port(&block)
        @spec.add_port(80, name: :http, &block)
      end
    end
  end
end
