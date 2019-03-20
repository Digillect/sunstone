require 'active_support'
require 'active_support/core_ext'
require 'recursive-open-struct'

module Sunstone
  class ValuesManager
    def initialize
      @values = {}
    end

    def values
      RecursiveOpenStruct.new(@values).freeze
    end

    def load(input_path, additional_files, variables)
      values_yaml = File.join(input_path, 'values.yaml')

      load_file values_yaml if File.exist? values_yaml

      additional_files.each do |file|
        file = File.absolute_path file

        # error "Values file #{file} doesn't exists" unless File.exist? file

        load_file file
      end

      @values.deep_merge! variables.deep_symbolize_keys
    end

    def load_file(path)
      values = YAML.load_file path

      @values.deep_merge! values.deep_symbolize_keys
    rescue StandardError => err
      raise "Unable to load values file #{path}: #{err.message}"
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

    private

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
  end
end
