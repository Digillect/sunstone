module Sunstone
  module Objects
    class LocalObjectReference
      attr_reader :name

      def initialize(name)
        @name = name.to_s
      end

      def to_hash
        { name: @name }
      end
    end
  end
end
