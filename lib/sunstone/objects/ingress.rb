require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/ingress_spec'
require 'sunstone/objects/ingress_rule'

module Sunstone
  module Objects
    class Ingress < KubernetesObject
      attr_reader :spec

      def initialize(name)
        super

        @spec = IngressSpec.new
      end

      def api_version
        'extensions/v1beta1'
      end

      def add_rule(host, service_name = nil, path: nil, service_port: 80)
        service_name ||= R.scope

        raise 'Service name must be specified or scope should be active' unless service_name

        rule = IngressRule.new(host).tap do |rule|
          rule.add_path service_name, service_port, path
        end

        @spec.rules.push rule
      end

      def to_hash
        super.merge! spec: @spec.to_hash
      end
    end
  end
end

R.register_resource :ingress, Sunstone::Objects::Ingress
