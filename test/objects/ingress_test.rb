require 'test_helper'
require 'sunstone/objects/ingress'

class IngressTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::Ingress.new :test
  end

  def test_properties_and_methods
    assert_property sut, :spec

    assert_respond_to sut, :add_rule
    assert_respond_to sut, :add_tls
  end
end
