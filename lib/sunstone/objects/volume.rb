module Sunstone
  module Objects
    class Volume
      attr_reader :name, :source

      def initialize(name, source)
        @name = name
        @source = source
      end

      def to_hash
        result = { name: @name.to_s }

        result[hash_key] = @source.to_hash

        result
      end

      private

      def hash_key
        case @source
        when ConfigMapVolumeSource
          :configMap
        when EmptyDirVolumeSource
          :emptyDir
        when HostPathVolumeSource
          :hostPath
        when NfsVolumeSource
          :nfs
        when PersistentVolumeClaimVolumeSource
          :persistentVolumeClaim
        when SecretVolumeSource
          :secret
        else
          raise 'Invalid or unsupported volume source'
        end
      end
    end
  end
end
