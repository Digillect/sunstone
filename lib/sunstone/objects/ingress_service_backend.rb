module Sunstone
  module Objects
    class IngressServiceBackend < BaseObject
      property :name, String
      property :port, ServiceBackendPort
    end
  end
end
