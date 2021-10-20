module Sunstone
  module Objects
    class LocalObjectReference < BaseObject
      property :name, String

      def initialize(name)
        super()

        @name = name.to_s
      end
    end
  end
end
