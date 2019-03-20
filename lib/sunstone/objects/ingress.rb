require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/ingress_rule'
require 'sunstone/objects/ingress_spec'
require 'sunstone/objects/ingress_tls'

module Sunstone
  module Objects
    class Ingress < KubernetesObject
      property :spec, IngressSpec

      def initialize(name)
        super
      end

      def api_version
        'extensions/v1beta1'
      end

      def add_rule(host, service_name = nil, path: nil, service_port: 80)
        service_name ||= metadata.name

        raise 'Service name must be specified or scope should be active' unless service_name

        rule = IngressRule.new(host).tap do |r|
          r.add_path service_name, service_port, path
        end

        @spec.rules << rule
      end

      def add_tls(secret_name, *hosts)
        @spec.tls << IngressTLS.new(secret_name, *hosts)
      end
    end
  end
end
