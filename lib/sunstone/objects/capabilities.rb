require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class Capabilities < BaseObject
      property :add, Array, String
      property :drop, Array, String

      def add(*values)
        return @add if values.empty?

        @add.concat(values.map(->(item) { item.to_s }))
      end

      def drop(*values)
        return @drop if values.empty?

        @drop.concat(values.map(->(item) { item.to_s }))
      end
    end
  end
end
