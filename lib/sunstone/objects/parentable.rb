module Sunstone
  module Objects
    module Parentable
      extend ActiveSupport::Concern

      included do
        attr_accessor :__parent
      end

      def __root
        return self unless __parent&.is_a?(Parentable)

        __parent.__root
      end
    end
  end
end
