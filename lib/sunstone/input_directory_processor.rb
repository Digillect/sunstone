module Sunstone
  class InputDirectoryProcessor
    def initialize(values, release)
      @values = values
      @release = release
    end

    def process_directory(path)
      setup_constants

      begin
        Dir.chdir path do
          $LOAD_PATH.push path

          process_directory_files(path)

          $LOAD_PATH.pop
        end
      rescue StandardError => err
        backtrace = err.backtrace.select { |line| line.start_with? path }

        new_err = err.class.new err.message
        new_err.set_backtrace backtrace

        raise new_err
      ensure
        teardown_constants
      end
    end

    private

    def process_directory_files(path)
      Dir.each_child path do |file|
        next unless file.end_with?('.rb')
        next unless file.start_with?('_')

        # noinspection RubyResolve
        require File.join(path, file)
      end

      Dir.each_child path do |file|
        next unless file.end_with?('.rb')
        next if file.start_with?('_')

        # noinspection RubyResolve
        require File.join(path, file)
      end
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
