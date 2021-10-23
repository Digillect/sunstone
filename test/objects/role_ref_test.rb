class RoleRefTest < Minitest::Test
  def test_initialization
    sut = Sunstone::Objects::RoleRef.new :a, :b, :c

    assert_equal :a, sut.name
    assert_equal :b, sut.kind
    assert_equal :c, sut.api_group
  end

  def test_serialization
    sut = Sunstone::Objects::RoleRef.new :a, :b, :c

    assert_equal({ kind: 'b', name: 'a', apiGroup: 'c' }.to_a, sut.to_hash.to_a)
  end
end
