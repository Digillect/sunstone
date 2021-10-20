module Sunstone
  module Objects
    class CrossVersionObjectReference < BaseObject
      property :api_version, String
      property :kind, String
      property :name, String
    end
  end
end
