module Sunstone
  class ErrorBeautifier
    attr_reader :backtrace, :kind, :message

    def initialize(kind, message, backtrace_locations, input_directory)
      @kind = kind
      @message = message

      @backtrace = if backtrace_locations.nil?
                     []
                   else
                     backtrace_locations.select { |l| l.absolute_path.start_with? input_directory }
                   end
    end
  end
end
