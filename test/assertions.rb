require 'minitest/assertions'

module Minitest::Assertions
  def assert_property(sut, name)
    assert sut.is_a?(Sunstone::Objects::BaseObject), "Expected #{mu_pp(sut)} to be inherited from Sunstone::Objects::BaseObject."
    # unless sut.is_a? Sunstone::Objects::BaseObject
    #   raise Minitest::Assertion, "Expected #{mu_pp(sut)} to be inherited from Sunstone::Objects::BaseObject."
    # end

    found = sut.class.class_properties.any? { |p| p.name == name.to_sym }

    assert found, "Expected #{mu_pp(sut)} to declare property #{name}."
  end
end
