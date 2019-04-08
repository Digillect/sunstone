require 'test_helper'
require 'sunstone/values_manager'

class ValuesManagerTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::ValuesManager.new
  end

  def test_primary_file_is_loaded
    values = sut.combine File.join(__dir__, 'data', 'values_access'), [], []

    assert_equal 'hello', values.value
  end

  def test_additional_files_are_loaded
    values = sut.combine File.join(__dir__, 'data', 'values_additional_files'),
                         [File.join(__dir__, 'data', 'values_additional_files', 'additional.yaml')],
                         []

    assert_equal 'world', values.value
  end

  def test_included_files_are_loaded
    values = sut.combine File.join(__dir__, 'data', 'values_includes'), [], []

    assert_equal 'a', values.a
    assert_equal 'c1', values.b.c
    assert_equal 'd2', values.b.d
    assert_equal 'e', values.e
  end
end
