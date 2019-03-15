require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class SELinuxOptions < BaseObject
      property :level, String
      property :role, String
      property :type, String
      property :user, String
    end
  end
end
