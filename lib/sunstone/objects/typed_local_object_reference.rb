module Sunstone
  module Objects
    class TypedLocalObjectReference < BaseObject
      property :name, String
      property :kind, String
      property :api_group, String

      def initialize(name = nil, kind = nil, api_group = nil)
        super()

        @name = name
        @kind = kind
        @api_group = api_group
      end
    end
  end
end
