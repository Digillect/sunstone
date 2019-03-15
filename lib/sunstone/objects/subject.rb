require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class Subject < BaseObject
      property :kind, String
      property :name, String
      property :namespace, String
      property :api_group, String

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
