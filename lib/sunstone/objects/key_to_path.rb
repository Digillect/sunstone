require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class KeyToPath < BaseObject
      property :key
      property :path
      property :mode

      def initialize(key, path, mode = nil)
        super()

        @key = key
        @path = path
        @mode = mode
      end
    end
  end
end
