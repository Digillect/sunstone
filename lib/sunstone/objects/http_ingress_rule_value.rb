require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class HTTPIngressRuleValue < BaseObject
      property :paths, readonly: true

      def initialize
        super

        @paths = []
      end
    end
  end
end
