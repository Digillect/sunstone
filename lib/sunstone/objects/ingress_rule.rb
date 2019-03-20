require 'sunstone/objects/base_object'
require 'sunstone/objects/http_ingress_rule_value'
require 'sunstone/objects/http_ingress_path'

module Sunstone
  module Objects
    class IngressRule < BaseObject
      property :host, String, readonly: true
      property :http, HTTPIngressRuleValue

      def initialize(host)
        super()

        @host = host
      end

      def add_path(service_name, service_port, path = nil)
        @http.paths << HTTPIngressPath.new(service_name, service_port, path)
      end
    end
  end
end
