require 'json'

module Sunstone
  module Formatters
    class JsonFormatter < Formatter
      protected

      def file_extension
        'json'
      end

      def format_object(object)
        JSON.pretty_generate object
      end
    end
  end
end
