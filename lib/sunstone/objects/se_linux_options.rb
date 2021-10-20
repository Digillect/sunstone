module Sunstone
  module Objects
    class SeLinuxOptions < BaseObject
      property :level, String
      property :role, String
      property :type, String
      property :user, String
    end
  end
end
