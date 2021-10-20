require 'optparse'

module Sunstone
  class Runner
    def run
      options = parse_options(ARGV)

      raise "Input directory #{options.input} does not exists." unless Dir.exist? options.input_directory

      release = create_release options
      objects = release.objects

      formatter_class = "Sunstone::Formatters::#{options.format.capitalize}Formatter".constantize

      formatter = formatter_class.new

      formatter.format objects, options, release
    rescue StandardError => e
      puts e.message

      e.backtrace_locations
       .select { |l| !l.absolute_path.nil? && l.absolute_path.start_with?(options.input_directory) }
       .each do |location|
        puts "    at #{location.path}:#{location.lineno}"
      end

      exit 1
    end

    private

    def create_release(options)
      Dir.chdir options.input_directory do
        values_manager = ValuesManager.new options.debug

        values = values_manager.combine options.input_directory, options.value_files, options.variables

        release_manager = ReleaseManager.new
        release = release_manager.create_release

        input_directory_processor = InputDirectoryProcessor.new options.input_directory, values, release

        input_directory_processor.process

        release
      end
    end

    FORMATS = %w[yaml json].freeze

    def parse_options(args)
      options = OpenStruct.new

      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: sunstone [options] [PATH]'
        opts.program_name = 'Sunstone'
        opts.version = Sunstone::VERSION

        opts.separator ''
        opts.separator 'Options:'

        options.output = STDOUT
        opts.on '-o', '--output PATH', 'specify path to output file or directory, defaults to standard output' do |path|
          options.output = File.absolute_path(path)
        end

        options.clean = false
        opts.on '-c', '--clean', 'clean up output before processing' do
          options.clean = true
        end

        options.split = false
        opts.on '-p', '--split', 'put each manifest into separate file' do
          options.split = true
        end

        options.variables = []
        opts.on '-s', '--set PATH=VALUE', 'set value at the specified path' do |v|
          options.variables << v
        end

        options.format = 'yaml'
        opts.on '-t', '--format FORMAT', FORMATS, "use specified output format [#{FORMATS.join(', ')}], defaults to YAML" do |format|
          options.format = format
        end

        options.value_files = []
        opts.on '-f', '--values valueFiles', Array, 'specify values in YAML file (can specify multiple)' do |files|
          options.value_files += files.map { |file| File.absolute_path(file) }
        end

        opts.separator ''
        opts.separator 'Global options:'

        options.debug = false
        opts.on '--debug', 'enable verbose output' do
          options.debug = true
        end

        opts.on '--version', 'show version' do
          puts "Sunstone #{Sunstone::VERSION}"
          exit
        end

        opts.on_tail '--help', 'show this message' do
          puts opts
          exit
        end
      end

      opt_parser.parse! args

      options.input_directory = File.absolute_path(ARGV.first || Dir.pwd)

      options
    end
  end
end
