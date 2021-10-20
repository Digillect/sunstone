module Sunstone
  module Objects
    class HostPathVolumeSource < BaseObject
      property :path, String
      property :type, String

      def initialize(path, type = nil)
        super()

        @path = path
        @type = type
      end
    end
  end
end
