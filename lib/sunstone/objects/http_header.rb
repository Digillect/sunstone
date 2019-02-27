require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class HttpHeader < BaseObject
      property :name
      property :value

      def initialize(name, value)
        super()

        @name = name
        @value = value
      end
    end
  end
end
