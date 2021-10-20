module Sunstone
  module Objects
    class SessionAffinityConfig < BaseObject
      property :client_ip, ClientIpConfig, serialized_name: :clientIP
    end
  end
end
