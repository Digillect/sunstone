module Sunstone
  module Objects
    class KubernetesObjectMetadata
      attr_accessor :namespace
      attr_reader :name, :labels, :annotations, :finalizers

      def initialize(name = nil)
        @name = name
        @namespace = nil
        @labels = {}
        @annotations = {}
        @finalizers = []
      end

      def empty?
        @name.blank? && @namespace.blank? && @labels.empty? && @annotations.empty? && @finalizers.empty?
      end

      def add_label(keys_and_values = {})
        @labels.merge! keys_and_values
      end

      def add_annotation(keys_and_values = {})
        @annotations.merge! keys_and_values
      end

      alias add_labels add_label
      alias add_annotations add_annotation

      def add_finalizer(finalizer)
        @finalizers.push finalizer
      end

      def to_hash
        result = {}

        result[:name] = @name.to_s if @name
        result[:namespace] = @namespace.to_s if @namespace
        result[:labels] = @labels.transform_values(&:to_s) unless @labels.empty?
        result[:annotations] = @annotations.transform_values(&:to_s) unless @annotations.empty?
        result[:finalizers] = @finalizers.map(&:to_s) unless @finalizers.empty?

        result
      end
    end
  end
end
