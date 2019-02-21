require 'sunstone/objects/config_map_volume_source'

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
        else
          raise 'Invalid or unsupported volume source'
        end
      end
    end
  end
end
