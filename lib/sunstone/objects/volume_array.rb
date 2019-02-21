require 'sunstone/objects/config_map_volume_source'
require 'sunstone/objects/volume'

module Sunstone
  module Objects
    class VolumeArray < Array
      def config_map(volume_name, *args)
        keys_and_paths = args.extract_options!
        config_map_name ||= args.first || R.scope

        raise 'ConfigMap name must be specified or scope must be active' if config_map_name.blank?

        source = ConfigMapVolumeSource.new config_map_name

        keys_and_paths.each_pair do |key, path|
          source.add_item key, path
        end

        yield source if block_given?

        volume = Volume.new volume_name, source

        push volume

        volume
      end
    end
  end
end
