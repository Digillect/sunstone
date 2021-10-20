module Sunstone
  module Objects
    class VolumeDevice < BaseObject
      property :name, String
      property :device_path, String

      def initialize(name, device_path)
        super()

        @name = name
        @device_path = device_path
      end
    end
  end
end
