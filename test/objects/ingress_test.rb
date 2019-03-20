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

  def test_add_rule_uses_provided_service_name
    sut.add_rule 'www.example.org', :frontend

    assert_equal :frontend, sut.spec.rules.first.http.paths.first.backend.service_name
  end

  def test_add_rule_uses_ingress_name_when_service_name_is_not_provided
    sut.add_rule 'www.example.org'

    assert_equal :test, sut.spec.rules.first.http.paths.first.backend.service_name
  end
end
