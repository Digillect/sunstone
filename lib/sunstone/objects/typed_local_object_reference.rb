require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class TypedLocalObjectReference < BaseObject
      property :name
      property :kind
      property :api_group

      def initialize(name = nil, kind = nil, api_group = nil)
        super()

        @name = name
        @kind = kind
        @api_group = api_group
      end

      def empty?
        @name.nil? && @kind.nil?
      end
    end
  end
end
