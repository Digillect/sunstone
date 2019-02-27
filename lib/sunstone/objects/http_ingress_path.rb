require 'sunstone/objects/base_object'
require 'sunstone/objects/ingress_backend'

module Sunstone
  module Objects
    class HTTPIngressPath < BaseObject
      property :backend, readonly: true
      property :path

      def initialize(service_name, service_port, path = nil)
        super()

        @backend = IngressBackend.new(service_name, service_port)
        @path = path
      end
    end
  end
end
