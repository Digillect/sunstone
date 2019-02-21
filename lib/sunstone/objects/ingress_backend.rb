module Sunstone
  module Objects
    class IngressBackend
      attr_reader :service_name, :service_port

      def initialize(service_name, service_port)
        @service_name = service_name
        @service_port = service_port
      end

      def to_hash
        { serviceName: @service_name.to_s, servicePort: @service_port }
      end
    end
  end
end
