require 'sunstone/objects/base_object'
require 'sunstone/objects/label_selector'

module Sunstone
  module Objects
    class PodAffinityTerm < BaseObject
      property :label_selector, readonly: true
      property :namespaces, readonly: true
      property :topology_key

      def initialize
        super

        @label_selector = LabelSelector.new
        @namespaces = []
      end

      def empty?
        @label_selector.empty? && @namespaces.empty? && @topology_key.blank?
      end

      def namespaces(*values)
        return @namespaces if values.empty?

        @namespaces.concat(values)
      end

      alias namespace namespaces
    end
  end
end
