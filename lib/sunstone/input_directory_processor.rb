module Sunstone
  class InputDirectoryProcessor
    def initialize(values, release)
      @values = values
      @release = release
    end

    def process_directory(path)
      Object.const_set :Values, @values
      Object.const_set :V, @values
      Object.const_set :Release, @release
      Object.const_set :R, @release

      begin
        Dir.chdir path do
          Dir.each_child path do |file|
            next unless file.end_with?('.rb')
            next unless file.start_with?('_')

            require File.join(path, file)
          end

          Dir.each_child path do |file|
            next unless file.end_with?('.rb')
            next if file.start_with?('_')

            require File.join(path, file)
          end
        end
      rescue StandardError => err
        backtrace = err.backtrace.select { |line| line.start_with? path }

        new_err = err.class.new err.message
        new_err.set_backtrace backtrace

        raise new_err
      ensure
        Object.send :remove_const, :Values
        Object.send :remove_const, :V
        Object.send :remove_const, :Release
        Object.send :remove_const, :R
      end
    end
  end
end
