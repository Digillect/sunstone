require 'sunstone/objects/capabilities'
require 'sunstone/objects/se_linux_options'

module Sunstone
  module Objects
    class SecurityContext < BaseObject
      property :allow_privilege_escalation, boolean: true
      property :capabilities, readonly: true
      property :privileged, boolean: true
      property :proc_mount
      property :readonly_root_filesystem, boolean: true, serialized_name: 'readOnlyRootFilesystem'
      property :run_as_group
      property :run_as_non_root, boolean: true
      property :run_as_user
      property :se_linux_options, readonly: true

      def initialize
        super

        @capabilities = Capabilities.new
        @se_linux_options = SELinuxOptions.new
      end

      def empty?
        @allow_privilege_escalation.nil? &&
          @capabilities.empty? &&
          @privileged.nil? &&
          @proc_mount.nil? &&
          @readonly_root_filesystem.nil? &&
          @run_as_group.nil? &&
          @run_as_non_root.nil? &&
          @run_as_user.nil? &&
          @se_linux_options.empty?
      end
    end
  end
end
