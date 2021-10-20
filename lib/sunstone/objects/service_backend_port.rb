require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class ServiceBackendPort < BaseObject
      property :name, String
      property :number, Integer
    end
  end
end
