require 'sunstone/objects/base_object'
require 'sunstone/objects/http_header'

module Sunstone
  module Objects
    class HttpGetAction < BaseObject
      property :path
      property :port
      property :host
      property :scheme
      property :http_headers, readonly: true

      def initialize(path, port)
        super()

        @path = path
        @port = port

        @headers = []

        @host = nil
        @scheme = nil
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
