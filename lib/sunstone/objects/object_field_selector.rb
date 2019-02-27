require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class ObjectFieldSelector < BaseObject
      property :field_path
      property :api_version

      def initialize(field_path, api_version = nil)
        super()

        @api_version = api_version
        @field_path = field_path
      end
    end
  end
end
