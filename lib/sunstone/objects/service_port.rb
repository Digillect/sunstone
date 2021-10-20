module Sunstone
  module Objects
    class ServicePort < BaseObject
      property :port, Integer
      property :name, String
      property :node_port, Integer
      property :protocol, String
      property :target_port

      def initialize(port)
        super()

        @port = port
      end
    end
  end
end
