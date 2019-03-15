require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class ConfigMapOrSecretKeySelector < BaseObject
      property :key, String, readonly: true
      property :name, String, readonly: true
      property :optional, TrueClass, readonly: true

      def initialize(key, name, optional = nil)
        super()

        @key = key
        @name = name
        @optional = optional
      end
    end
  end
end
