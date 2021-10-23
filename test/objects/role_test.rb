class RoleTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::Role.new :test
  end

  def test_add_rule_adds_item_to_the_list
    sut.add_rule

    refute_empty sut.rules
  end
end
