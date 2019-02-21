module Sunstone
  module Objects
    class VolumeMount
      attr_reader :mount_path, :mount_propagation, :name, :readonly, :sub_path

      def initialize(volume_name, mount_path, readonly = nil, mount_propagation = nil, sub_path = nil)
        @name = volume_name
        @mount_path = mount_path
        @readonly = readonly
        @mount_propagation = mount_propagation
        @sub_path = sub_path
      end

      def to_hash
        result = { name: @name.to_s, mountPath: @mount_path.to_s }

        result[:subPath] = @sub_path.to_s unless @sub_path.blank?
        result[:readonly] = !!@readonly unless @readonly.nil?
        result[:mount_propagation] = @mount_propagation.to_s unless @mount_propagation.blank?

        result
      end
    end
  end
end
