require 'recursive-open-struct'
require 'sunstone/objects/kubernetes_object'

module Sunstone
  module Objects
    class CustomResource < KubernetesObject
      attr_reader :fields

      def initialize(name)
        super(name)

        @fields = RecursiveOpenStruct.new
      end

      protected

      def post_serialize_properties(result)
        result.deep_merge! @fields.to_hash
      end
    end
  end
end
