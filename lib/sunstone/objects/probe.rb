require 'sunstone/objects/base_object'
require 'sunstone/objects/exec_action'
require 'sunstone/objects/http_get_action'
require 'sunstone/objects/tcp_socket_action'

module Sunstone
  module Objects
    class Probe < BaseObject
      property :exec, readonly: true
      property :http_get, readonly: true
      property :tcp_socket, readonly: true

      property :failure_threshold
      property :initial_delay_seconds
      property :period_seconds
      property :success_threshold
      property :timeout

      def use_command(*command)
        raise 'Only one action can be used in probe' unless action_empty?

        @exec = ExecAction.new(*command)
      end

      def use_http(path, port = 80, &block)
        raise 'Only one action can be used in probe' unless action_empty?

        @http_get = HttpGetAction.new path, port

        @http_get.instance_eval(&block) if block_given?

        @http_get
      end

      def use_tcp(port, host = nil)
        raise 'Only one action can be used in probe' unless action_empty?

        @tcp_socket = TcpSocketAction.new port, host
      end

      def action_empty?
        @exec.nil? && @http_get.nil? && @tcp_socket.nil?
      end

      def empty?
        @failure_threshold.nil? && @initial_delay.nil? && @period.nil? && @success_threshold.nil? && @timeout.nil? && action_empty?
      end
    end
  end
end
