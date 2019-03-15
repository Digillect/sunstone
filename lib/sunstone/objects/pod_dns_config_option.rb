require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class PodDNSConfigOption < BaseObject
      property :name, String
      property :value, String, serializer: ->(value) { value.to_s }

      def initialize(name, value = nil)
        super()

        @name = name
        @value = value
      end
    end
  end
end
