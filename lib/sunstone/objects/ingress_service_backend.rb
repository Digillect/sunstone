require 'sunstone/objects/base_object'
require 'sunstone/objects/service_backend_port'

module Sunstone
  module Objects
    class IngressServiceBackend < BaseObject
      property :name, String
      property :port, ServiceBackendPort
    end
  end
end
