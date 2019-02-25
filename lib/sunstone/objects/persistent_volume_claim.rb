require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/persistent_volume_claim_spec'

module Sunstone
  module Objects
    class PersistentVolumeClaim < KubernetesObject
      attr_reader :spec

      def initialize(name)
        super

        @spec = PersistentVolumeClaimSpec.new
      end

      def api_version
        'core/v1'
      end

      def access_modes(*args)
        @spec.access_modes.concat args
      end

      alias access_mode access_modes

      def match_labels(labels = {})
        @spec.selector.merge! labels
      end

      def storage_class_name(value = nil)
        return @spec.storage_class_name unless value

        @spec.storage_class_name = value
      end

      def storage_request(volume)
        @spec.storage_request = volume
      end

      def to_hash
        result = super

        result[:spec] = @spec.to_hash

        result
      end
    end
  end
end

R.register_resource :persistent_volume_claim, Sunstone::Objects::PersistentVolumeClaim