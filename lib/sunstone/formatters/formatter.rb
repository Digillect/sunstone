module Sunstone
  module Formatters
    class Formatter
      def format(objects, options)
        split = options.split && options.output != STDOUT
        output = initialize_output(options)

        objects.each do |object|
          io = split ? io_for_object(object, output) : output

          object = object.to_hash.deep_stringify_keys
          str = format_object object

          io.puts str

          io.close if split
        end

        output.close unless output.is_a? String
      end

      protected

      def file_extension
        ''
      end

      def format_object(object)
        raise 'format_object method must be implemented by concrete renderer'
      end

      private

      def io_for_object(object, output)
        resource = R.resource_name(object.class).to_s.underscore.dasherize
        file_name = "#{object.metadata.name.parameterize}-#{resource}.#{file_extension}"
        file_path = File.join(output, file_name)

        File.open file_path, 'w'
      end

      def initialize_output(options)
        output = options.output

        return output unless output.is_a? String

        prepare_output_directory options.split ? output : File.dirname(output)
        clean_output_directory_or_file output, options.split if options.clean

        unless options.split
          output = File.join(output, File.basename(options.input)) if Dir.exist? output
          output = "#{output}.#{file_extension}" unless output.end_with? ".#{file_extension}"

          output = File.open output, 'w'
        end

        output
      end

      def prepare_output_directory(path)
        FileUtils.mkdir_p path unless Dir.exist? path
      rescue IOError => err
        error "Unable to create directory #{path}: #{err.message}"
      end

      def clean_output_directory_or_file(output, split)
        if split
          begin
            FileUtils.rm_rf Dir.glob("#{output}/*"), secure: true
          rescue IOError => err
            error "Unable to clean directory #{output}: #{err.message}"
          end
        else
          FileUtils.rm output, force: true
        end
      end
    end
  end
end
