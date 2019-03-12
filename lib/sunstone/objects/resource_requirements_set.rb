require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class ResourceRequirementsSet < BaseObject
      property :cpu
      property :memory
      property :storage
      property :ephemeral_storage, serialized_name: 'ephemeral-storage'

      def initialize
        super

        @extended_resources = {}
      end

      def empty?
        @cpu.nil? && @memory.nil? && @storage.nil? && @ephemeral_storage.nil? && @extended_resources.empty?
      end

      def extended_resource(name, value = nil)
        name = name.to_sym

        return @extended_resources[name] if value.nil?

        @extended_resources[name] = value
      end

      protected

      def post_serialize_properties(result)
        result.merge! @extended_resources.transform_keys(&:to_sym)
      end
    end
  end
end
