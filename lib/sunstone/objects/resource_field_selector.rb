module Sunstone
  module Objects
    class ResourceFieldSelector
      attr_reader :container_name, :divisor, :resource

      def initialize(resource, container_name = nil, divisor = nil)
        @resource = resource
        @container_name = container_name
        @divisor = divisor
      end

      def to_hash
        result = { resource: @resource }

        result[:containerName] = @container_name unless @container_name.blank?
        result[:divisor] = @divisor unless @divisor.blank?

        result
      end
    end
  end
end
