module Sunstone
  module Objects
    class ConfigMapVolumeSource < BaseObject
      property :name, String, readonly: true
      property :items, BaseArray, KeyToPath
      property :default_mode, Integer
      property :optional, TrueClass

      def initialize(config_map_name)
        super()

        @name = config_map_name
      end

      def add_item(key, path, mode = nil)
        @items << KeyToPath.new(key, path, mode)
      end
    end
  end
end
