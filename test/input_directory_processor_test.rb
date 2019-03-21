require 'test_helper'
require 'English'
require 'sunstone/input_directory_processor'
require 'sunstone/release_manager'
require 'sunstone/values_manager'

class InputDirectoryProcessorTest < Minitest::Test
  def test_underscore_files_are_loaded_first
    sut = Sunstone::InputDirectoryProcessor.new File.join(__dir__, 'data/load_order'), nil, nil

    assert_output "_file#{$INPUT_RECORD_SEPARATOR}file#{$INPUT_RECORD_SEPARATOR}" do
      sut.process
    end
  end

  def test_variables_are_available
    values_manager = Sunstone::ValuesManager.new
    values_manager.combine File.join(__dir__, 'data/values_access'), [], []
    values = values_manager.values

    sut = Sunstone::InputDirectoryProcessor.new File.join(__dir__, 'data/values_access'), values, nil

    assert_output "hello#{$INPUT_RECORD_SEPARATOR}hello#{$INPUT_RECORD_SEPARATOR}" do
      sut.process
    end
  end

  def test_release_is_available
    release_manager = Sunstone::ReleaseManager.new
    release = release_manager.create_release

    sut = Sunstone::InputDirectoryProcessor.new File.join(__dir__, 'data/release_access'), nil, release

    assert_output "hello#{$INPUT_RECORD_SEPARATOR}world#{$INPUT_RECORD_SEPARATOR}" do
      sut.process
    end
  end

  def test_simple_backtrace_is_filtered
    sut = Sunstone::InputDirectoryProcessor.new File.join(__dir__, 'data/with_errors'), nil, nil

    backtrace = nil

    begin
      sut.process
    rescue StandardError => err
      backtrace = err.backtrace
    end

    refute_nil backtrace
    refute_empty backtrace
    assert_equal 1, backtrace.length

    location = backtrace.first

    assert_match /file\.rb:2/, location
  end

  def test_nested_backtrace_is_filtered
    release_manager = Sunstone::ReleaseManager.new
    release = release_manager.create_release

    sut = Sunstone::InputDirectoryProcessor.new File.join(__dir__, 'data/nested_errors'), nil, release

    backtrace = nil

    begin
      sut.process
    rescue StandardError => err
      backtrace = err.backtrace
    end

    refute_nil backtrace
    refute_empty backtrace
    assert_equal 4, backtrace.length
  end

  def test_nested_folder
    sut = Sunstone::InputDirectoryProcessor.new File.join(__dir__, 'data/nested_folders'), nil, nil

    expected = <<~CONTENT
      _outer
      outer
      _inner1
      inner1
      _inner2
      inner2
    CONTENT

    assert_output expected do
      sut.process
    end
  end
end
