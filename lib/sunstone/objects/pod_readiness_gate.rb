require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class PodReadinessGate < BaseObject
      property :condition_type

      def initialize(condition_type = nil)
        super()

        @condition_type = condition_type
      end
    end
  end
end
