class RoleBindingTest < MiniTest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::RoleBinding.new :test
  end

  def test_properties_and_methods
    assert_kind_of Sunstone::Objects::ClusterRoleBinding, sut

    assert_respond_to sut, :namespace
    assert_respond_to sut, :role
  end
end
