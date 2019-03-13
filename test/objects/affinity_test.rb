require 'test_helper'
require 'sunstone/objects/affinity'

class AffinityTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::Affinity.new
  end

  def test_properties_present
    assert_property sut, :node_affinity
    assert_property sut, :pod_affinity
    assert_property sut, :pod_anti_affinity
  end

  def test_empty_on_fresh_instance
    assert_empty sut
  end
end
