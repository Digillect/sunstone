module Sunstone
  module Objects
    class Capabilities < BaseObject
      property :add, Array, String
      property :drop, Array, String

      def add(*values)
        return @add if values.empty?

        @add.concat values.map(&:to_s)
      end

      def drop(*values)
        return @drop if values.empty?

        @drop.concat values.map(&:to_s)
      end
    end
  end
end
