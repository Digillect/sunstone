require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class KubernetesObjectMetadata < BaseObject
      property :name, String, readonly: true
      property :namespace, String
      property :labels, Hash
      property :annotations, Hash
      property :finalizers, Array, String

      def initialize(name = nil)
        super()

        @name = name
      end

      def labels(keys_and_values = {})
        return @labels if keys_and_values.empty?

        @labels.merge! keys_and_values
      end

      def annotations(keys_and_values = {})
        return @annotations if keys_and_values.empty?

        @annotations.merge! keys_and_values
      end

      def finalizers(*finalizers)
        return @finalizers if finalizers.empty?

        @finalizers.concat finalizers
      end

      alias label labels
      alias annotation annotations
      alias finalizer finalizers
    end
  end
end
