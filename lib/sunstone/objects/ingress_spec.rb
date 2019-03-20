require 'sunstone/objects/base_object'
require 'sunstone/objects/ingress_backend'
require 'sunstone/objects/ingress_rule'
require 'sunstone/objects/ingress_tls'

module Sunstone
  module Objects
    class IngressSpec < BaseObject
      property :backend, IngressBackend
      property :tls, BaseArray, IngressTLS
      property :rules, BaseArray, IngressRule
    end
  end
end
