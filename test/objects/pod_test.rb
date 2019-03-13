require 'test_helper'
require 'sunstone/objects/pod'

class PodTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::Pod.new :test
  end

  def test_properties
    assert_property sut, :spec
    assert_respond_to sut, :pod_spec
  end
end
