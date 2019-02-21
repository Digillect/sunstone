module Sunstone
  module Objects
    class EnvVarSource
      def initialize(selector)
        @selector = selector
      end

      def to_hash
        result = {}

        result[hash_key] = @selector.to_hash

        result
      end

      private

      def hash_key
        case @selector
        when ConfigMapKeySelector
          :configMapKeyRef
        when ObjectFieldSelector
          :fieldRef
        when ResourceFieldSelector
          :resourceFieldRef
        when SecretKeySelector
          :secretKeyRef
        else
          raise 'Invalid EnvVarSource'
        end
      end
    end
  end
end
