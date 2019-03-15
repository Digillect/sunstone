require 'sunstone/objects/base_object'
require 'sunstone/objects/client_ip_config'

module Sunstone
  module Objects
    class SessionAffinityConfig < BaseObject
      property :client_ip, ClientIPConfig, serialized_name: :clientIP
    end
  end
end
