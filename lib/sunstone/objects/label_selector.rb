require 'sunstone/objects/base_object'
require 'sunstone/objects/label_selector_requirement'

module Sunstone
  module Objects
    class LabelSelector < BaseObject
      property :match_expressions, Array, LabelSelectorRequirement
      property :match_labels, Hash

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
    end
  end
end
