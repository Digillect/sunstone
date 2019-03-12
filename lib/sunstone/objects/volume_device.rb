require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class VolumeDevice < BaseObject
      property :name
      property :device_path

      def initialize(name, device_path)
        super()

        @name = name
        @device_path = device_path
      end
    end
  end
end
