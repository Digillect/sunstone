require 'sunstone/objects/base_object'
require 'sunstone/objects/label_selector'

module Sunstone
  module Objects
    class PodAffinityTerm < BaseObject
      property :label_selector, LabelSelector
      property :namespaces, Array, String
      property :topology_key, String

      def namespaces(*values)
        return @namespaces if values.empty?

        @namespaces.concat(values)
      end

      alias namespace namespaces
    end
  end
end
