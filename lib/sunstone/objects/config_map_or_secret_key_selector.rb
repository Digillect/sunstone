module Sunstone
  module Objects
    class ConfigMapOrSecretKeySelector
      attr_reader :key, :name, :optional

      def initialize(key, name, optional = nil)
        @key = key
        @name = name
        @optional = optional
      end

      def to_hash
        result = { key: @key.to_s, name: @name.to_s }

        result[:optional] = @optional unless @optional.nil?

        result
      end
    end
  end
end
