module Sunstone
  class InputDirectoryProcessor
    def initialize(input_directory, values, release)
      @input_directory = input_directory
      @values = values
      @release = release
    end

    def process
      components = Pathname.new File.join(@input_directory, 'components')

      return unless components.exist? && components.directory?

      setup_constants

      begin
        process_directory components
      ensure
        teardown_constants
      end
    end

    private

    def process_directory(path)
      process_directory_files path
      process_subdirectories path
    end

    def process_directory_files(path)
      path.glob('*.rb').select(&:file?).sort.each(&method(:require))
    end

    def process_subdirectories(path)
      path.children.select(&:directory?).sort.each(&method(:process_directory))
    end

    def setup_constants
      Object.const_set :Values, @values
      Object.const_set :V, @values
      Object.const_set :Release, @release
      Object.const_set :R, @release
    end

    def teardown_constants
      Object.send :remove_const, :Values
      Object.send :remove_const, :V
      Object.send :remove_const, :Release
      Object.send :remove_const, :R
    end
  end
end
