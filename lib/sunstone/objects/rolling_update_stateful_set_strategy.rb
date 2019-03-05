require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class RollingUpdateStatefulSetStrategy < BaseObject
      property :partition

      def empty?
        @partition.nil?
      end
    end
  end
end
