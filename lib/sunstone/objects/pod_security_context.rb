require 'sunstone/objects/base_object'
require 'sunstone/objects/se_linux_options'
require 'sunstone/objects/sysctl'

module Sunstone
  module Objects
    class PodSecurityContext < BaseObject
      property :fs_group, Integer
      property :run_as_group, Integer
      property :run_as_non_root, TrueClass
      property :run_as_user, Integer
      property :se_linux_options, SELinuxOptions
      property :supplemental_groups, Array, Integer
      property :sysctls, BaseArray, Sysctl

      def sysctls(names_and_values = {})
        return @sysctls if names_and_values.empty?

        names_and_values.each_pair do |name, value|
          @sysctls << Sysctl.new(name, value)
        end
      end

      alias sysctl sysctls
    end
  end
end
