require 'sunstone/objects/base_object'
require 'sunstone/objects/http_ingress_path'

module Sunstone
  module Objects
    class HTTPIngressRuleValue < BaseObject
      property :paths, BaseArray, HTTPIngressPath

      def add_path(&block)
        path = HTTPIngressPath.new

        path.instance_eval(&block) unless block.nil?

        @paths << path
      end
    end
  end
end
