require 'optparse'
require 'sunstone/error_beautifier'
require 'sunstone/input_directory_processor'
require 'sunstone/release_manager'
require 'sunstone/values_manager'
require 'sunstone/formatters/json_formatter'
require 'sunstone/formatters/yaml_formatter'

module Sunstone
  def self.run
    options = parse_options(ARGV)

    raise "Input directory #{options.input} does not exists." unless Dir.exist? options.input

    values_manager = ValuesManager.new

    variables = values_manager.convert_variables options.variables

    if options.debug
      puts '# Command line provided values:'
      puts variables.to_hash.deep_stringify_keys.to_yaml
      puts
    end

    values_manager.load options.input, options.values_files, variables

    values = values_manager.values

    if options.debug
      puts '# Combined values:'
      puts values.to_hash.to_yaml
      puts
    end

    release_manager = ReleaseManager.new
    release = release_manager.create_release

    input_directory_processor = InputDirectoryProcessor.new values, release

    input_directory_processor.process_directory options.input

    formatter_class = "Sunstone::Formatters::#{options.format.capitalize}Formatter".constantize

    objects = release.objects
    formatter = formatter_class.new

    formatter.format objects, options, release
  rescue StandardError => err
    puts err
    puts err.backtrace

    beautifier = ErrorBeautifier.new err.class, err.message, err.backtrace_locations, options.input

    puts beautifier.message

    beautifier.backtrace.each do |location|
      puts "    at #{location.path}:#{location.lineno}"
    end

    exit 1
  end

  FORMATS = %w[yaml json].freeze

  def self.parse_options(args)
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

      options.values_files = []
      opts.on '-f', '--values valueFiles', Array, 'specify values in YAML file (can specify multiple)' do |files|
        options.values_files += files.map { |file| File.absolute_path(file) }
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

    options.input = File.absolute_path(ARGV.first || Dir.pwd)

    options
  end
end
