module Sunstone
  module Objects
    class ResourceRequirements < BaseObject
      property :limits, ResourceRequirementsSet
      property :requests, ResourceRequirementsSet
    end
  end
end
