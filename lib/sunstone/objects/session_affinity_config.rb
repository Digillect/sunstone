require 'sunstone/objects/client_ip_config'

module Sunstone
  module Objects
    class SessionAffinityConfig
      attr_reader :client_ip

      def initialize
        @client_ip = ClientIPConfig.new
      end

      def empty?
        @client_ip.empty?
      end

      def to_hash
        { clientIP: @client_ip.to_hash }
      end
    end
  end
end
