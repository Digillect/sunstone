module Sunstone
  module Objects
    class ObjectFieldSelector
      attr_reader :api_version, :field_path

      def initialize(field_path, api_version = nil)
        @api_version = api_version
        @field_path = field_path
      end

      def to_hash
        result = { fieldPath: @field_path }

        result[:apiVersion] = @api_version unless @api_version.blank?

        result
      end
    end
  end
end
