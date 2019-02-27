require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class Subject < BaseObject
      property :kind, readonly: true
      property :name, readonly: true
      property :namespace, readonly: true
      property :api_group, readonly: true

      def initialize(kind, name, namespace = nil, api_group = nil)
        super()

        @kind = kind
        @name = name
        @namespace = namespace
        @api_group = api_group
      end
    end
  end
end
