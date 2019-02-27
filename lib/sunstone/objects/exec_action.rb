require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class ExecAction < BaseObject
      property :command, readonly: true

      def initialize(*command)
        super()

        @command = command
      end
    end
  end
end
