module Sunstone
  module Objects
    class KubernetesObject < BaseObject
      property :metadata, KubernetesObjectMetadata, initialize: false

      def initialize(name)
        super()

        @metadata = KubernetesObjectMetadata.new(name)
      end

      @api_kind = nil
      @api_group_and_version = nil

      class << self
        attr_reader :api_kind, :api_group_and_version

        def api_version(version, kind = nil)
          @api_group_and_version = version
          @api_kind = kind
        end
      end

      private

      def pre_serialize_properties(result)
        kind = self.class.api_kind || self.class.name.demodulize
        version = self.class.api_group_and_version

        raise "API Version must be specified for #{kind}" unless version

        result[:apiVersion] = version
        result[:kind] = kind
      end
    end
  end
end
