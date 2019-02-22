module Sunstone
  module Objects
    class ExecAction
      attr_reader :command

      def initialize(*command)
        @command = command
      end

      def to_hash
        { command: @command.map(&:to_s) }
      end
    end
  end
end
