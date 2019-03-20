require 'sunstone/objects/base_object'
require 'sunstone/objects/key_to_path'

module Sunstone
  module Objects
    class SecretVolumeSource < BaseObject
      property :secret_name, readonly: true
      property :items, BaseArray, KeyToPath
      property :default_mode, Integer
      property :optional, TrueClass

      def initialize(secret_name)
        super()

        @secret_name = secret_name
      end

      def add_item(key, path, mode = nil)
        @items << KeyToPath.new(key, path, mode)
      end
    end
  end
end
