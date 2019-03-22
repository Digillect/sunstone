module Sunstone
  class ErrorBeautifier
    attr_reader :backtrace, :kind, :message
    def initialize(kind, message, backtrace_locations, input_directory)
      @kind = kind
      @message = message
      @backtrace = backtrace_locations.select { |l| l.absolute_path.start_with? input_directory }
    end

    class Location
      attr_reader :absolute_path, :lineno, :path

      def initialize(path, absolute_path, lineno)
        @lineno = lineno
        @absolute_path = absolute_path
        @path = path
      end
    end
  end
end
