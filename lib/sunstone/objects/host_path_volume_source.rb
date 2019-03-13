require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class HostPathVolumeSource < BaseObject
      property :path
      property :type

      def initialize(path, type = nil)
        super()

        @path = path
        @type = type
      end
    end
  end
end
