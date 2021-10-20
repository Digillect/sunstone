module Sunstone
  module Objects
    class IngressBackend < BaseObject
      property :resource, TypedLocalObjectReference
      property :service, IngressServiceBackend
    end
  end
end
