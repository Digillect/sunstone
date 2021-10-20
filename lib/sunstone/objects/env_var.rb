module Sunstone
  module Objects
    class EnvVar
      attr_reader :name, :value

      def initialize(name, value)
        @name = name
        @value = value
      end

      def to_hash
        result = { name: @name.to_s }

        result[:value] = @value.to_s unless @value.is_a? EnvVarSource
        result[:valueFrom] = @value.to_hash if @value.is_a? EnvVarSource

        result
      end
    end
  end
end
