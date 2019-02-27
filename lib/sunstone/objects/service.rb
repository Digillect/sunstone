require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/service_spec'

module Sunstone
  module Objects
    class Service < KubernetesObject
      property :spec, readonly: true

      def initialize(name)
        super

        @spec = ServiceSpec.new
      end

      def api_version
        'v1'
      end

      def match_labels(labels = {})
        @spec.selector.merge! labels
      end

      def expose_default_http_port
        @spec.add_port 80, name: :http
      end
    end
  end
end

R.register_resource :service, Sunstone::Objects::Service
