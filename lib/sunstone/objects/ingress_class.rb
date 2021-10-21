module Sunstone
  module Objects
    class IngressClass < KubernetesObject
      api_version 'networking.k8s.io/v1'

      property :spec, IngressClassSpec

      def add_rule(host, service_name = nil, path: nil, path_type: 'ImplementationSpecific', service_port: 80, &block)
        service_name ||= metadata.name

        @spec.add_rule(host) do
          add_service_path service_name, service_port, path, path_type

          instance_eval(&block) unless block.nil?
        end
      end

      def add_tls(secret_name, *hosts)
        @spec.add_tls(secret_name, *hosts)
      end
    end
  end
end
