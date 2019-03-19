require 'test_helper'
require 'sunstone/error_beautifier'

class ErrorBeautifierTest < Minitest::Test
  def test_out_of_scope_locations_are_filtered
    backtrace = []

    backtrace << Location.new('/a/b/c', 'file.rb', 12)
    backtrace << Location.new('/d/e/f', 'another.rb', 44)
    backtrace << Location.new('/a/b/c', 'third.rb', 99)

    sut = Sunstone::ErrorBeautifier.new StandardError, 'syntax error', backtrace, '/a/b/c'

    assert_equal 2, sut.backtrace.length
    assert_equal 12, sut.backtrace[0].lineno
    assert_equal 99, sut.backtrace[1].lineno
  end

  class Location
    attr_reader :lineno, :path, :absolute_path

    def initialize(path, file, lineno)
      @path = file
      @absolute_path = File.join(path, file)
      @lineno = lineno
    end
  end
end
