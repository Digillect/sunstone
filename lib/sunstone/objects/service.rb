require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/service_spec'

module Sunstone
  module Objects
    class Service < KubernetesObject
      property :spec, ServiceSpec

      def initialize(name)
        super
      end

      def api_version
        'v1'
      end

      def match_labels(labels = {})
        @spec.selector.merge! labels
      end

      def expose_default_http_port(&block)
        @spec.add_port(80, name: :http, &block)
      end
    end
  end
end
