require 'sunstone/objects/ingress_backend'

module Sunstone
  module Objects
    class IngressSpec
      attr_reader :rules, :tls

      def initialize
        @rules = []
        @tls = []
      end

      def backend(service_name = nil, service_port = nil)
        return @backend unless service_name && service_port

        @backend = IngressBackend.new(service_name, service_port)
      end

      def to_hash
        result = {}

        result[:backend] = @backend.to_hash unless @backend.nil?
        result[:tls] = @tls.map(&:to_hash) unless @tls.empty?
        result[:rules] = @rules.map(&:to_hash) unless @rules.empty?

        result
      end
    end
  end
end
