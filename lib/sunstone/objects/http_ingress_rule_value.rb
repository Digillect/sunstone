require 'sunstone/objects/base_object'
require 'sunstone/objects/http_ingress_path'

module Sunstone
  module Objects
    class HTTPIngressRuleValue < BaseObject
      property :paths, BaseArray, HTTPIngressPath
    end
  end
end
