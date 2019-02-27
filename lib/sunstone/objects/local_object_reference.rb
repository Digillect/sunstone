require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class LocalObjectReference < BaseObject
      property :name

      def initialize(name)
        super()

        @name = name.to_s
      end
    end
  end
end
