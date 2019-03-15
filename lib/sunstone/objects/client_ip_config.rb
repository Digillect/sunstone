require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class ClientIPConfig < BaseObject
      property :timeout_seconds, String
    end
  end
end
