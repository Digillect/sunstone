require 'sunstone/objects/base_object'
require 'sunstone/objects/ingress_backend'

module Sunstone
  module Objects
    class HTTPIngressPath < BaseObject
      property :backend, IngressBackend
      property :path, String
      property :path_type, String
    end
  end
end
