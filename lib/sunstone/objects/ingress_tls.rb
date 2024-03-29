module Sunstone
  module Objects
    class IngressTls < BaseObject
      property :secret_name, String
      property :hosts, Array, String, initialize: false

      def initialize(secret_name, *hosts)
        super()

        @hosts = hosts.dup
        @secret_name = secret_name
      end
    end
  end
end
