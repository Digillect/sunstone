require 'sunstone/objects/http_ingress_rule_value'
require 'sunstone/objects/http_ingress_path'

module Sunstone
  module Objects
    class IngressRule
      attr_reader :host, :http

      def initialize(host)
        @host = host
        @http = HTTPIngressRuleValue.new
      end

      def add_path(service_name, service_port, path = nil)
        @http.paths.push HTTPIngressPath.new(service_name, service_port, path)
      end

      def to_hash
        { host: @host.to_s, http: @http.to_hash }
      end
    end
  end
end
