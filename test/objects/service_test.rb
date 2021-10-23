class ServiceTest < MiniTest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::Service.new :test
  end

  def test_properties_and_methods
    assert_property sut, :spec

    assert_respond_to sut, :match_labels
    assert_respond_to sut, :expose_default_http_port
  end
end
