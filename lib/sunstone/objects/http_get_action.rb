require 'sunstone/objects/http_header'

module Sunstone
  module Objects
    class HttpGetAction
      attr_accessor :host, :path, :port, :scheme
      attr_reader :headers

      def initialize(path, port)
        @path = path
        @port = port

        @headers = []

        @host = nil
        @scheme = nil
      end

      def to_hash
        result = { path: @path.to_s, port: @port }

        result[:host] = @host.to_s if @host
        result[:scheme] = @scheme.to_s if @scheme
        result[:httpHeaders] = @headers.map(&:to_hash) unless @headers.empty?

        result
      end
    end
  end
end
