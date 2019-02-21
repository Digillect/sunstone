require 'sunstone/objects/ingress_backend'

module Sunstone
  module Objects
    class HTTPIngressPath
      attr_reader :backend, :path

      def initialize(service_name, service_port, path = nil)
        @backend = IngressBackend.new(service_name, service_port)
        @path = path
      end

      def to_hash
        result = { backend: @backend.to_hash }

        result[:path] = @path.to_s unless @path.blank?

        result
      end
    end
  end
end
