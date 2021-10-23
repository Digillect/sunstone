class DaemonSetTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::DaemonSet.new :test
  end

  def test_properties_and_methods
    assert_kind_of Sunstone::Objects::PodTemplateExtensions, sut

    assert_property sut, :spec

    assert_respond_to sut, :pod_template
  end
end
