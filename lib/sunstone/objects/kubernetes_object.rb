module Sunstone
  module Objects
    class KubernetesObject < BaseObject
      property :metadata, KubernetesObjectMetadata, initialize: false

      def initialize(name)
        super()

        @metadata = KubernetesObjectMetadata.new(name)
      end

      def kind
        self.class.name.demodulize
      end

      def api_version
        raise "API Version must be specified for #{kind}"
      end

      private

      def pre_serialize_properties(result)
        result[:apiVersion] = api_version
        result[:kind] = kind
      end
    end
  end
end
