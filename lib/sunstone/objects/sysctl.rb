require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class Sysctl < BaseObject
      property :name
      property :value

      def initialize(name, value = nil)
        super()

        @name = name
        @value = value
      end
    end
  end
end
