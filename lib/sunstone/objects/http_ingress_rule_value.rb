module Sunstone
  module Objects
    class HTTPIngressRuleValue
      attr_reader :paths

      def initialize
        @paths = []
      end

      def to_hash
        { paths: @paths.map(&:to_hash) }
      end
    end
  end
end
