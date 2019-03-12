require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class SELinuxOptions < BaseObject
      property :level
      property :role
      property :type
      property :user

      def empty?
        @level.nil? && @role.nil? && @type.nil? && @user.nil?
      end
    end
  end
end
