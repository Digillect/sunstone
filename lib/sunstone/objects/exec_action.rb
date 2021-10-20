module Sunstone
  module Objects
    class ExecAction < BaseObject
      property :command, Array, String, initialize: false

      def initialize(*command)
        super()

        @command = command
      end
    end
  end
end
