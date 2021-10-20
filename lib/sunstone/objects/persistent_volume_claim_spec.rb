module Sunstone
  module Objects
    class PersistentVolumeClaimSpec < BaseObject
      property :storage_class_name, String
      property :access_modes, Array, String
      property :data_source, TypedLocalObjectReference
      property :resources, ResourceRequirements
      property :selector, LabelSelector
      property :volume_mode, String
      property :volume_name, String

      def storage_request(volume)
        @resources.requests.storage volume
      end

      def storage_limit(volume)
        @resources.limits.storage volume
      end
    end
  end
end
