require 'sunstone/objects/base_object'
require 'sunstone/objects/typed_local_object_reference'
require 'sunstone/objects/ingress_service_backend'

module Sunstone
  module Objects
    class IngressBackend < BaseObject
      property :resource, TypedLocalObjectReference
      property :service, IngressServiceBackend
    end
  end
end
