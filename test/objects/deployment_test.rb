class DeploymentTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::Deployment.new :test
  end

  def test_properties_and_methods
    assert_kind_of Sunstone::Objects::PodTemplateExtensions, sut
    assert_kind_of Sunstone::Objects::PodTemplateOwner, sut

    assert_property sut, :spec

    assert_respond_to sut, :match_labels
    assert_respond_to sut, :replicas
  end
end
