require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class ConfigMapOrSecretKeySelector < BaseObject
      property :key, readonly: true
      property :name, readonly: true
      property :optional, boolean: true, readonly: true

      def initialize(key, name, optional = nil)
        super()

        @key = key
        @name = name
        @optional = optional
      end
    end
  end
end
