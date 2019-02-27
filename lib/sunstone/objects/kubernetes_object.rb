require 'sunstone/objects/base_object'
require 'sunstone/objects/kubernetes_object_metadata'

module Sunstone
  module Objects
    class KubernetesObject < BaseObject
      property :metadata, readonly: true

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
        result[:metadata] = @metadata.to_hash
      end
    end
  end
end
