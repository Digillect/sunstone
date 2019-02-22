module Sunstone
  module Objects
    class HttpHeader
      attr_reader :name, :value

      def initialize(name, value)
        @name = name
        @value = value
      end

      def to_hash
        { name: @name.to_s, value: @value.to_s }
      end
    end
  end
end
