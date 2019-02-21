module Sunstone
  module Objects
    class Subject
      attr_reader :api_group, :kind, :name, :namespace

      def initialize(kind, name, namespace = nil, api_group = nil)
        @kind = kind
        @name = name
        @namespace = namespace
        @api_group = api_group
      end

      def to_hash
        result = { kind: @kind.to_s, name: @name.to_s }

        result[:namespace] = @namespace.to_s if @namespace
        result[:apiGroup] = @api_group.to_s if @api_group

        result
      end
    end
  end
end
