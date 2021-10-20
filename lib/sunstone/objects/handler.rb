module Sunstone
  module Objects
    class Handler < BaseObject
      include ActionsOwner

      alias empty? action_empty?
    end
  end
end
