require 'sunstone/objects/base_object'
require 'sunstone/objects/ingress_backend'

module Sunstone
  module Objects
    class IngressSpec < BaseObject
      property :backend, readonly: true
      property :tls, readonly: true
      property :rules, readonly: true

      def initialize
        super

        @backend = IngressBackend.new
        @rules = []
        @tls = []
      end
    end
  end
end
