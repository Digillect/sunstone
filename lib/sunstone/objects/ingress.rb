module Sunstone
  module Objects
    class Ingress < KubernetesObject
      property :spec, IngressSpec

      def api_version
        'networking.k8s.io/v1'
      end

      def add_service_rule(host, service_name = nil, path: nil, path_type: :ImplementationSpecific, service_port: 80, &block)
        service_name ||= metadata.name

        add_ingress_rule(host) do
          add_service_path service_name, service_port, path, path_type

          instance_eval(&block) unless block.nil?
        end
      end

      def add_ingress_rule(host, &block)
        rule = IngressRule.new(host).tap do |r|
          r.instance_eval(&block) if block_given?
        end

        @spec.rules << rule
      end

      def add_tls(secret_name, *hosts)
        @spec.tls << IngressTls.new(secret_name, *hosts)
      end
    end
  end
end
