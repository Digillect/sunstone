require 'recursive-open-struct'

module Sunstone
  module Objects
    class CustomResource < KubernetesObject
      attr_reader :fields

      def initialize(name)
        super(name)

        @fields = RecursiveOpenStruct.new
      end

      def to_hash
        result = super

        result.deep_merge @fields.to_hash
      end
    end
  end
end
