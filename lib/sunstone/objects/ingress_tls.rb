require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class IngressTLS < BaseObject
      property :hosts, readonly: true
      property :secret_name

      def initialize(secret_name, *hosts)
        super()

        @hosts = hosts.dup
        @secret_name = secret_name
      end

      def empty?
        @secret_name.blank?
      end
    end
  end
end
