require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class VolumeMount < BaseObject
      property :name, String
      property :mount_path, String
      property :sub_path, String
      property :readonly, TrueClass
      property :mount_propagation, String

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
