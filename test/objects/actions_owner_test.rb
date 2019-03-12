require 'test_helper'
require 'sunstone/objects/base_object'
require 'sunstone/objects/actions_owner'

class ActionsOwnerTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Handler.new
  end

  def test_including_adds_actions
    assert sut.instance_variable_defined? '@exec'.to_sym
    assert sut.instance_variable_defined? '@http_get'.to_sym
    assert sut.instance_variable_defined? '@tcp_socket'.to_sym
  end

  def test_action_empty_on_fresh_instance
    assert sut.action_empty?
  end

  def test_action_empty
    sut.use_command 'ls'

    refute sut.action_empty?
  end

  def test_use_command_creates_action
    sut.use_command 'ls', '-al'

    refute_nil sut.exec

    assert %w[ls -al], sut.exec.command
  end

  def test_use_command_asserts_single_action
    sut.use_command 'ls'

    assert_raises Sunstone::Objects::MultipleActionsError, 'Only one action can be specified' do
      sut.use_command 'ping'
    end
  end

  def test_use_http_creates_action
    sut.use_http '/api/status'

    refute_nil sut.http_get

    assert '/api/status', sut.http_get.path
  end

  def test_use_http_evaluates_block
    block_evaluated = false

    sut.use_http '/api/status' do
      block_evaluated = true
    end

    assert block_evaluated
  end

  def test_use_http_asserts_single_action
    sut.use_command 'ls'

    assert_raises Sunstone::Objects::MultipleActionsError, 'Only one action can be specified' do
      sut.use_http '/api/status'
    end
  end

  def test_use_tcp_creates_action
    sut.use_tcp 8080, 'www.example.org'

    refute_nil sut.tcp_socket

    assert 8080, sut.tcp_socket.port
    assert 'www.example.org', sut.tcp_socket.host
  end

  def test_use_tcp_asserts_single_action
    sut.use_command 'ls'

    assert_raises Sunstone::Objects::MultipleActionsError, 'Only one action can be specified' do
      sut.use_tcp 80
    end
  end

  class Handler < Sunstone::Objects::BaseObject
    include Sunstone::Objects::ActionsOwner
  end
end
