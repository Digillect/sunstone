require 'sunstone/objects/base_object'
require 'sunstone/objects/typed_local_object_reference'
require 'sunstone/objects/label_selector'

module Sunstone
  module Objects
    class PersistentVolumeClaimSpec < BaseObject
      property :access_modes, readonly: true
      property :data_source, readonly: true
      property :selector, readonly: true
      property :storage_class_name
      property :volume_mode
      property :volume_name

      attr_accessor :storage_request, :storage_limit

      def initialize
        super

        @access_modes = []
        @data_source = TypedLocalObjectReference.new
        @selector = LabelSelector.new
      end

      private

      def post_serialize_properties(result)
        return unless @storage_request || @storage_limit

        resources = {}

        resources[:request] = { storage: @storage_request.to_s } if @storage_request
        resources[:limit] = { storage: @storage_limit.to_s } if @storage_limit

        result[:resources] = resources
      end
    end
  end
end
