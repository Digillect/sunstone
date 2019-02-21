require 'recursive-open-struct'

module Sunstone
  module Objects
    class CustomResource < KubernetesObject
      def initialize(name, fields = {})
        super(name)

        @fields = RecursiveOpenStruct.new fields
      end

      attr_reader :fields

      def to_hash
        result = super

        result.deep_merge @fields.to_hash
      end
    end
  end
end
