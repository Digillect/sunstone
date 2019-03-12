require 'sunstone/objects/base_object'
require 'sunstone/objects/label_selector'
require 'sunstone/objects/resource_requirements'
require 'sunstone/objects/typed_local_object_reference'

module Sunstone
  module Objects
    class PersistentVolumeClaimSpec < BaseObject
      property :access_modes, readonly: true
      property :data_source, readonly: true
      property :resources, readonly: true
      property :selector, readonly: true
      property :storage_class_name
      property :volume_mode
      property :volume_name

      def initialize
        super

        @access_modes = []
        @data_source = TypedLocalObjectReference.new
        @resources = ResourceRequirements.new
        @selector = LabelSelector.new
      end

      def storage_request(volume)
        @resources.requests.storage volume
      end

      def storage_limit(volume)
        @resources.limits.storage volume
      end
    end
  end
end
