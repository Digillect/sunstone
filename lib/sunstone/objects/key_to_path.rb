module Sunstone
  module Objects
    class KeyToPath
      attr_reader :key, :mode, :path

      def initialize(key, path, mode = nil)
        @key = key
        @path = path
        @mode = mode
      end

      def to_hash
        result = { key: @key.to_s, path: @path.to_s }

        result[:mode] = @mode unless @mode.blank?

        result
      end
    end
  end
end
