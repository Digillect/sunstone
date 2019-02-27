require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class VolumeMount < BaseObject
      property :name
      property :mount_path
      property :sub_path
      property :readonly, boolean: true
      property :mount_propagation

      def initialize(volume_name, mount_path, readonly = nil, mount_propagation = nil, sub_path = nil)
        super()

        @name = volume_name
        @mount_path = mount_path
        @readonly = readonly
        @mount_propagation = mount_propagation
        @sub_path = sub_path
      end
    end
  end
end
