require 'sunstone/objects/label_selector_requirement'

module Sunstone
  module Objects
    class LabelSelector
      attr_reader :match_expressions, :match_labels

      def initialize
        @match_expressions = []
        @match_labels = {}
      end

      def in(key, *values)
        @match_expressions.push LabelSelectorRequirement.new(key, LabelSelectorRequirement::IN, values)
      end

      def not_in(key, *values)
        @match_expressions.push LabelSelectorRequirement.new(key, LabelSelectorRequirement::NOT_IN, values)
      end

      def exists(key)
        @match_expressions.push LabelSelectorRequirement.new(key, LabelSelectorRequirement::EXISTS)
      end

      def does_not_exists(key)
        @match_expressions.push LabelSelectorRequirement.new(key, LabelSelectorRequirement::DOES_NOT_EXISTS)
      end

      def equals(labels = {})
        @match_labels.merge! labels
      end

      def empty?
        @match_expressions.empty? && @match_labels.empty?
      end

      def to_hash
        return nil if empty?

        result = {}

        result[:matchExpressions] = @match_expressions.map(&:to_hash) unless @match_expressions.empty?
        result[:matchLabels] = @match_labels.transform_values(&:to_s) unless @match_labels.empty?

        result
      end
    end
  end
end
