require 'sunstone/objects/base_object'
require 'sunstone/objects/resource_requirements_set'

module Sunstone
  module Objects
    class ResourceRequirements < BaseObject
      property :limits, ResourceRequirementsSet
      property :requests, ResourceRequirementsSet
    end
  end
end
