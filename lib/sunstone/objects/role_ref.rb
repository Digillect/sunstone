require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class RoleRef < BaseObject
      property :kind
      property :name
      property :api_group

      def initialize(name, kind, api_group)
        super()

        @name = name
        @kind = kind
        @api_group = api_group
      end
    end
  end
end
