require 'sunstone/objects/base_object'
require 'sunstone/objects/client_ip_config'

module Sunstone
  module Objects
    class SessionAffinityConfig < BaseObject
      property :client_ip, readonly: true, serialized_name: :clientIP

      def initialize
        super

        @client_ip = ClientIPConfig.new
      end

      def empty?
        @client_ip.empty?
      end
    end
  end
end
