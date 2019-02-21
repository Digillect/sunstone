require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/service_spec'

module Sunstone
  module Objects
    class Service < KubernetesObject
      attr_reader :spec

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

      def to_hash
        result = super

        result[:spec] = @spec.to_hash

        result
      end
    end
  end
end

R.register_resource :service, Sunstone::Objects::Service
