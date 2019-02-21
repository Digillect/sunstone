require 'sunstone/objects/key_to_path'

module Sunstone
  module Objects
    class ConfigMapVolumeSource
      attr_reader :items, :name
      attr_accessor :default_mode, :optional

      def initialize(config_map_name)
        @name = config_map_name
        @items = []
      end

      def add_item(key, path, mode = nil)
        @items.push KeyToPath.new(key, path, mode)
      end

      def to_hash
        result = { name: @name.to_s }

        result[:items] = @items.map(&:to_hash) unless @items.empty?
        result[:defaultMode] = @default_mode unless @default_mode.blank?
        result[:optional] = !!@optional unless @optional.nil?

        result
      end
    end
  end
end
