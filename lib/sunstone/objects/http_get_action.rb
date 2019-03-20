require 'sunstone/objects/base_object'
require 'sunstone/objects/http_header'

module Sunstone
  module Objects
    class HttpGetAction < BaseObject
      property :path, String
      property :port
      property :host, String
      property :scheme, String
      property :http_headers, BaseArray, HttpHeader

      def initialize(path, port)
        super()

        @path = path
        @port = port
      end

      def headers(names_and_values = {})
        names_and_values.each do |name, value|
          @http_headers.push HttpHeader.new(name, value)
        end
      end

      alias header headers
    end
  end
end
