require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class EmptyDirVolumeSource < BaseObject
      property :medium
      property :size_limit

      def initialize(size_limit = nil, medium = nil)
        super()

        @medium = medium
        @size_limit = size_limit
      end
    end
  end
end
