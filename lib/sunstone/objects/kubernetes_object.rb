require 'sunstone/objects/kubernetes_object_metadata'

module Sunstone
  module Objects
    class KubernetesObject
      attr_reader :metadata

      def initialize(name)
        @metadata = KubernetesObjectMetadata.new(name)
      end

      def kind
        self.class.name.demodulize
      end

      def api_version
        raise "API Version must be specified for #{kind}"
      end

      def to_hash
        {
          apiVersion: api_version,
          kind: kind,
          metadata: @metadata.to_hash
        }
      end
    end
  end
end
