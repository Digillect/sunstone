require 'active_support/concern'
require 'sunstone/objects/exec_action'
require 'sunstone/objects/http_get_action'
require 'sunstone/objects/tcp_socket_action'

module Sunstone
  module Objects
    class MultipleActionsError < StandardError
    end

    module ActionsOwner
      extend ActiveSupport::Concern

      included do
        property :exec, ExecAction, initialize: false
        property :http_get, HttpGetAction, initialize: false
        property :tcp_socket, TcpSocketAction, initialize: false
      end

      def action_empty?
        @exec.nil? && @http_get.nil? && @tcp_socket.nil?
      end

      def use_command(*command)
        raise MultipleActionsError, 'Only one action can be specified' unless action_empty?

        @exec = ExecAction.new(*command)
      end

      def use_http(path, port = 80, &block)
        raise MultipleActionsError, 'Only one action can be specified' unless action_empty?

        @http_get = HttpGetAction.new path, port

        @http_get.instance_eval(&block) if block_given?

        @http_get
      end

      def use_tcp(port, host = nil)
        raise MultipleActionsError, 'Only one action can be specified' unless action_empty?

        @tcp_socket = TcpSocketAction.new port, host
      end
    end
  end
end
