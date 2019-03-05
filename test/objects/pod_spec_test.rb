require 'test_helper'
require 'sunstone/objects/pod_spec'

class PodSpecTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::PodSpec.new
  end

  def test_image_pull_secrets_adds_a_secret
    sut.image_pull_secrets :test

    refute_empty sut.image_pull_secrets

    item = sut.image_pull_secrets[0]

    assert_instance_of Sunstone::Objects::LocalObjectReference, item
    assert_equal 'test', item.name
  end
end
