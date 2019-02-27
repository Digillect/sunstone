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
    end
  end
end
