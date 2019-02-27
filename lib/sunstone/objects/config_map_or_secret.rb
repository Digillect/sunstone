require 'active_support/concern'

module Sunstone
  module Objects
    module ConfigMapOrSecret
      extend ActiveSupport::Concern

      def set(keys_and_values)
        keys_and_values.each_pair do |key, value|
          data[key] = value
        end

        self
      end

      def file(keys_and_paths)
        keys_and_paths.each_pair do |key, path|
          content = File.read path

          data[key] = content
        end

        self
      end
    end
  end
end
