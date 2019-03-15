require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class ResourceFieldSelector < BaseObject
      property :resource, String
      property :container_name, String
      property :divisor

      def initialize(resource, container_name = nil, divisor = nil)
        super()

        @resource = resource
        @container_name = container_name
        @divisor = divisor
      end
    end
  end
end
