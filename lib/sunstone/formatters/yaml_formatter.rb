require 'yaml'

module Sunstone
  module Formatters
    class YamlFormatter < Formatter
      protected

      def file_extension
        'yaml'
      end

      def format_object(object)
        object.to_yaml
      end
    end
  end
end
