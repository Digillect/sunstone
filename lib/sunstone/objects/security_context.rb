require 'sunstone/objects/capabilities'
require 'sunstone/objects/se_linux_options'

module Sunstone
  module Objects
    class SecurityContext < BaseObject
      property :allow_privilege_escalation, TrueClass
      property :capabilities, Capabilities
      property :privileged, TrueClass
      property :proc_mount, String
      property :readonly_root_filesystem, TrueClass, serialized_name: 'readOnlyRootFilesystem'
      property :run_as_group, Integer
      property :run_as_non_root, TrueClass
      property :run_as_user, Integer
      property :se_linux_options, SELinuxOptions
    end
  end
end
