module Sunstone
  module Objects
    class ConfigMapOrSecretEnvSource < BaseObject
      property :name
      property :optional, TrueClass, readonly: true

      def initialize(name, optional = nil)
        raise ArgumentError, 'Name must be specified' if name.blank?

        super()

        @name = name
        @optional = optional
      end
    end
  end
end
