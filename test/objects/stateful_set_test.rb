class StatefulSetTest < MiniTest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::StatefulSet.new :test
  end

  def test_properties_and_methods
    assert_property sut, :spec

    assert_respond_to sut, :volume_claim
  end
end
