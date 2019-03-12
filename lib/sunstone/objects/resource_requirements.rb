require 'sunstone/objects/base_object'
require 'sunstone/objects/resource_requirements_set'

module Sunstone
  module Objects
    class ResourceRequirements < BaseObject
      property :limits, readonly: true
      property :requests, readonly: true

      def initialize
        super

        @limits = ResourceRequirementsSet.new
        @requests = ResourceRequirementsSet.new
      end

      def empty?
        @limits.empty? && @requests.empty?
      end
    end
  end
end
