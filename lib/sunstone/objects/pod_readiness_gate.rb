module Sunstone
  module Objects
    class PodReadinessGate < BaseObject
      property :condition_type, String

      def initialize(condition_type = nil)
        super()

        @condition_type = condition_type
      end
    end
  end
end
