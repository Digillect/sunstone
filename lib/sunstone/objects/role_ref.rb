module Sunstone
  module Objects
    class RoleRef < BaseObject
      property :kind, String
      property :name, String
      property :api_group, String

      def initialize(name, kind, api_group)
        super()

        @name = name
        @kind = kind
        @api_group = api_group
      end
    end
  end
end
