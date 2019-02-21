require 'base64'
require 'sunstone/objects/config_map_or_secret'

module Sunstone
  module Objects
    class Secret < ConfigMapOrSecret
      attr_accessor :type

      def initialize(name)
        super
      end

      def to_hash
        result = super

        result[:type] = @type.to_s if @type

        result
      end

      protected

      def convert_value(value)
        Base64.strict_encode64(value ? value.to_s : '')
      end
    end
  end
end

R.register_resource :secret, Sunstone::Objects::Secret
