module Sunstone
  module Objects
    class ConfigMapOrSecretEnvSource
      attr_reader :name

      def initialize(name, optional = nil)
        raise ArgumentError, 'Name must be specified' if name.blank?

        @name = name
        @optional = optional
      end

      def optional?
        @optional
      end

      def to_hash
        result = { name: @name.to_s }

        result[:optional] = @optional unless @optional.nil?

        result
      end
    end
  end
end
