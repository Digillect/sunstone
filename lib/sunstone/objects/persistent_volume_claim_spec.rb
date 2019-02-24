require 'sunstone/objects/typed_local_object_reference'
require 'sunstone/objects/label_selector'

module Sunstone
  module Objects
    class PersistentVolumeClaimSpec
      attr_accessor :storage_class_name, :volume_mode, :volume_name, :storage_request, :storage_limit
      attr_reader :access_modes, :data_source, :selector

      def initialize
        @access_modes = []
        @data_source = TypedLocalObjectReference.new
        @selector = LabelSelector.new
      end

      def to_hash
        result = {}

        result[:accessModes] = @access_modes.map(&:to_s) unless @access_modes.empty?
        result[:dataSource] = @data_source.to_hash unless @data_source.empty?
        result[:selector] = @selector.to_hash unless @selector.empty?
        result[:storageClassName] = @storage_class_name.to_s if @storage_class_name
        result[:volumeMode] = @volume_mode.to_s if @volume_mode
        result[:volumeName] = @volume_name.to_s if @volume_name

        if @storage_request || @storage_limit
          resources = {}

          resources[:request] = { storage: @storage_request.to_s } if @storage_request
          resources[:limit] = { storage: @storage_limit.to_s } if @storage_limit

          result[:resources] = resources
        end

        result
      end
    end
  end
end
