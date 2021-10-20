module Sunstone
  module Objects
    class PersistentVolumeClaim < KubernetesObject
      property :spec, PersistentVolumeClaimSpec

      def initialize(name)
        super
      end

      def api_version
        'v1'
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

      def storage_limit(volume)
        @spec.storage_limit volume
      end

      def storage_request(volume)
        @spec.storage_request volume
      end
    end
  end
end
