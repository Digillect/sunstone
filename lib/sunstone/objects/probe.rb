require 'sunstone/objects/exec_action'
require 'sunstone/objects/http_get_action'
require 'sunstone/objects/tcp_socket_action'

module Sunstone
  module Objects
    class Probe
      attr_writer :failure_threshold, :initial_delay, :period, :success_threshold, :timeout
      attr_reader :exec, :http_get, :tcp_socket

      def failure_threshold(value = nil)
        @failure_threshold = value if value

        @failure_threshold
      end

      def initial_delay(value = nil)
        @initial_delay = value if value

        @initial_delay
      end

      def period(value = nil)
        @period = value if value

        @period
      end

      def success_threshold(value = nil)
        @success_threshold = value if value

        @success_threshold
      end

      def timeout(value = nil)
        @timeout = value if value

        @timeout
      end

      def use_command(*command)
        raise 'Only one action can be used in probe' unless action_empty?

        @exec = ExecAction.new *command
      end

      def use_http(path, port = 80)
        raise 'Only one action can be used in probe' unless action_empty?

        @http_get = HttpGetAction.new path, port

        yield @http_get if block_given?

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

      def to_hash
        result = {}

        result[:exec] = @exec.to_hash if @exec
        result[:httpGet] = @http_get.to_hash if @http_get
        result[:tcp_socket] = @tcp_socket.to_hash if @tcp_socket

        result[:failureThreshold] = @failure_threshold if @failure_threshold
        result[:initialDelaySeconds] = @initial_delay if @initial_delay
        result[:periodSeconds] = @period if @period
        result[:success_threshold] = @success_threshold if @success_threshold
        result[:timeoutSeconds] = @timeout if @timeout

        result
      end
    end
  end
end
