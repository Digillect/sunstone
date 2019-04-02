require 'test_helper'
require 'sunstone/objects/policy_rule'

class PolicyRuleTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::PolicyRule.new
  end

  def test_api_groups_adds_list_of_groups
    sut.api_groups :a, :b, :c

    assert_equal %w[a b c], sut.instance_variable_get('@api_groups')
  end
end
