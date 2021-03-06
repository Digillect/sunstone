require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class IngressBackend < BaseObject
      property :service_name, String
      property :service_port

      def initialize(service_name = nil, service_port = nil)
        super()

        @service_name = service_name
        @service_port = service_port
      end
    end
  end
end
