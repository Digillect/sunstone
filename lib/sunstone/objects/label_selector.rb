module Sunstone
  module Objects
    class LabelSelector < BaseObject
      property :match_expressions, BaseArray, LabelSelectorRequirement
      property :match_labels, Hash

      def in(key, *values)
        @match_expressions << LabelSelectorRequirement.new(key, LabelSelectorRequirement::IN, values)
      end

      def not_in(key, *values)
        @match_expressions << LabelSelectorRequirement.new(key, LabelSelectorRequirement::NOT_IN, values)
      end

      def exists(key)
        @match_expressions << LabelSelectorRequirement.new(key, LabelSelectorRequirement::EXISTS)
      end

      def does_not_exists(key)
        @match_expressions << LabelSelectorRequirement.new(key, LabelSelectorRequirement::DOES_NOT_EXISTS)
      end

      def equals(labels = {})
        @match_labels.merge! labels
      end
    end
  end
end
