require 'sunstone/objects/config_map_volume_source'
require 'sunstone/objects/empty_dir_volume_source'
require 'sunstone/objects/host_path_volume_source'
require 'sunstone/objects/persistent_volume_claim_volume_source'
require 'sunstone/objects/secret_volume_source'
require 'sunstone/objects/nfs_volume_source'

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
        when NFSVolumeSource
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
