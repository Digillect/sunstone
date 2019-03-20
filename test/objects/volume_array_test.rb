require 'test_helper'
require 'sunstone/objects/pod'

class VolumeArrayTest < Minitest::Test
  attr_reader :sut, :pod

  def setup
    @pod = Sunstone::Objects::Pod.new :test
    @sut = @pod.pod_spec.volumes
  end

  def test_volume_array_has_access_to_pod
    assert_same pod, sut.__root
  end
end
