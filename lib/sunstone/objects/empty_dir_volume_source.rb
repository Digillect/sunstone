module Sunstone
  module Objects
    class EmptyDirVolumeSource < BaseObject
      property :medium, String
      property :size_limit

      def initialize(size_limit = nil, medium = nil)
        super()

        @medium = medium
        @size_limit = size_limit
      end
    end
  end
end
