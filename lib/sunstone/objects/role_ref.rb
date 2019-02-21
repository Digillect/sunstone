module Sunstone
  module Objects
    class RoleRef
      attr_accessor :api_group, :kind, :name

      def initialize(name, kind, api_group)
        @name = name
        @kind = kind
        @api_group = api_group
      end

      def to_hash
        { kind: @kind.to_s, name: @name.to_s, apiGroup: @api_group.to_s }
      end
    end
  end
end
