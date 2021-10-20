module Sunstone
  module Objects
    class ObjectFieldSelector < BaseObject
      property :field_path, String
      property :api_version, String

      def initialize(field_path, api_version = nil)
        super()

        @api_version = api_version
        @field_path = field_path
      end
    end
  end
end
