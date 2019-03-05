require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class KubernetesObjectMetadata < BaseObject
      property :name, readonly: true
      property :namespace
      property :labels, readonly: true
      property :annotations, readonly: true
      property :finalizers, readonly: true

      def initialize(name = nil)
        super()

        @name = name
        @labels = {}
        @annotations = {}
        @finalizers = []
      end

      def empty?
        @name.blank? && @namespace.blank? && @labels.empty? && @annotations.empty? && @finalizers.empty?
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
