require 'active_support'
require 'active_support/core_ext'
require 'hashie/mash'
require 'yaml'

module Sunstone
  class ValuesManager
    attr_reader :values

    def initialize(debug = false)
      @debug = debug
    end

    def combine(input_path, additional_files, variables)
      values = {}

      load_files values, input_path, additional_files
      load_variables values, variables

      print_combined_values values if @debug

      @values = Hashie::Mash.new(values).freeze
    end

    private

    def load_files(values, input_path, additional_files)
      values_yaml = File.join(input_path, 'values.yaml')

      load_file values, values_yaml if File.exist? values_yaml

      additional_files.each do |file|
        file = File.absolute_path file

        # error "Values file #{file} doesn't exists" unless File.exist? file

        load_file values, file
      end
    end

    def load_file(values, path)
      file_values = YAML.load_file path
      files_to_include = file_values.delete '$include'

      values.deep_merge! file_values.deep_symbolize_keys

      process_includes values, files_to_include, File.dirname(path) if files_to_include
    rescue StandardError => err
      raise "Unable to load values file #{path}: #{err.message}"
    end

    def process_includes(values, files_to_include, base_path)
      if files_to_include.is_a? String
        load_file values, File.join(base_path, files_to_include)
      elsif files_to_include.is_a? Array
        files_to_include.each do |file_to_include|
          load_file values, File.join(base_path, file_to_include.to_s)
        end
      else
        raise 'Value for $include must be a file name or array of file names'
      end
    end

    def load_variables(values, variables)
      variables = convert_variables variables

      print_command_line_variables variables if @debug

      values.deep_merge! variables.deep_symbolize_keys
    end

    def convert_variables(variables)
      result = {}

      variables.each do |variable|
        name_and_value = variable.split('=')
        name = name_and_value.first
        value = name_and_value.second || 'true'

        set_value(result, name, convert_value(value))
      end

      result
    end

    def convert_value(value)
      if value.start_with?('\'', '\"')
        value[1..-1]
      elsif value == 'true'
        true
      elsif value == 'false'
        false
      elsif value == 'nil'
        nil
      elsif /^[0-9]+$/.match?(value)
        value.to_i
      else
        value
      end
    end

    def set_value(values, name, value)
      parts = name.split('.')

      parts.to(-2).each do |part|
        part = part.to_sym

        values = if values.key?(part.to_sym)
                   values[part.to_sym]
                 else
                   values[part.to_sym] = {}
                 end
      end

      values[parts.last.to_sym] = value
    end

    def print_command_line_variables(variables)
      puts '# Command line provided values:'
      puts variables.deep_stringify_keys.to_yaml
      puts
    end

    def print_combined_values(values)
      puts '# Combined values:'
      puts values.to_hash.to_yaml
      puts
    end
  end
end
