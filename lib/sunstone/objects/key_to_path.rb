require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class KeyToPath < BaseObject
      property :key, String
      property :path, String
      property :mode, Integer

      def initialize(key, path, mode = nil)
        super()

        @key = key
        @path = path
        @mode = mode
      end
    end
  end
end
