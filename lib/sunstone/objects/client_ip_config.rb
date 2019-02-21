module Sunstone
  module Objects
    class ClientIPConfig
      attr_accessor :timeout_seconds

      def empty?
        @timeout_seconds.blank?
      end

      def to_hash
        { timeoutSeconds: @timeout_seconds }
      end
    end
  end
end
