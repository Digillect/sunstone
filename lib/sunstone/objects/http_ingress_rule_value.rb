require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class HTTPIngressRuleValue < BaseObject
      property :paths, Array, String
    end
  end
end
