require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class NFSVolumeSource < BaseObject
      property :server, String
      property :path, String
      property :readonly, TrueClass, serialized_name: 'readOnly'

      def initialize(server, path, readonly = nil)
        super()

        @server = server
        @path = path
        @readonly = readonly
      end
    end
  end
end
