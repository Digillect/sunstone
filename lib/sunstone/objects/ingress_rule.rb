module Sunstone
  module Objects
    class IngressRule < BaseObject
      property :host, String, readonly: true
      property :http, HttpIngressRuleValue

      def initialize(host)
        super()

        @host = host
      end

      def add_service_path(service_name, service_port, path = nil, path_type = :ImplementationSpecific)
        http.add_path do
          backend.service.name = service_name

          if service_port.is_a? Integer
            backend.service.port.number = service_port
          else
            backend.service.port.name = service_port
          end

          self.path = path
          self.path_type = path_type
        end
      end
    end
  end
end
