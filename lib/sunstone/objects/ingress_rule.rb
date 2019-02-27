require 'sunstone/objects/base_object'
require 'sunstone/objects/http_ingress_rule_value'
require 'sunstone/objects/http_ingress_path'

module Sunstone
  module Objects
    class IngressRule < BaseObject
      property :host, readonly: true
      property :http, readonly: true

      def initialize(host)
        super()

        @host = host
        @http = HTTPIngressRuleValue.new
      end

      def add_path(service_name, service_port, path = nil)
        @http.paths.push HTTPIngressPath.new(service_name, service_port, path)
      end
    end
  end
end
