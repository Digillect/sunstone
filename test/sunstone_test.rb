require "test_helper"

class SunstoneTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sunstone::VERSION
  end
end
