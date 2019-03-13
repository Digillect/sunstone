require 'sunstone/objects/base_object'
require 'sunstone/objects/key_to_path'

module Sunstone
  module Objects
    class SecretVolumeSource < BaseObject
      property :secret_name, readonly: true
      property :items, readonly: true
      property :default_mode
      property :optional, boolean: true

      def initialize(config_map_name)
        super()

        @name = config_map_name
        @items = []
      end

      def add_item(key, path, mode = nil)
        @items.push KeyToPath.new(key, path, mode)
      end
    end
  end
end
