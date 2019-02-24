module Sunstone
  module Objects
    class TypedLocalObjectReference
      attr_accessor :api_group, :kind, :name

      def initialize(name = nil, kind = nil, api_group = nil)
        @name = name
        @kind = kind
        @api_group = api_group
      end

      def empty?
        @name.nil? && @kind.nil?
      end
      def to_hash
        result = { name: @name.to_s, kind: @kind.to_s }

        result[:apiGroup] = @api_group.to_s if @api_group

        result
      end
    end
  end
end
