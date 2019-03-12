require 'sunstone/objects/base_object'
require 'sunstone/objects/se_linux_options'
require 'sunstone/objects/sysctl'

module Sunstone
  module Objects
    class PodSecurityContext < BaseObject
      property :fs_group
      property :run_as_group
      property :run_as_non_root, boolean: true
      property :run_as_user
      property :se_linux_options, readonly: true
      property :supplemental_groups, readonly: true
      property :sysctls, readonly: true

      def initialize
        super

        @se_linux_options = SELinuxOptions.new
        @supplemental_groups = []
        @sysctls = []
      end

      def empty?
        @fs_group.nil? && @run_as_group.nil? && @run_as_non_root.nil? && @run_as_user.nil? && @se_linux_options.empty? && @supplemental_groups.empty? && @sysctls.empty?
      end

      def sysctls(names_and_values = {})
        return @sysctls if names_and_values.empty?

        names_and_values.each_pair do |name, value|
          @sysctls.push Sysctl.new(name, value)
        end
      end

      alias sysctl sysctls
    end
  end
end
