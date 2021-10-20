require 'hashie/mash'

module Sunstone
  module Objects
    class CustomResource < KubernetesObject
      attr_reader :fields

      def initialize(name)
        super(name)

        @fields = Hashie::Mash.new
      end

      protected

      def post_serialize_properties(result)
        result.deep_merge! @fields.deep_symbolize_keys
      end
    end
  end
end
