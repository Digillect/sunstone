require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class IngressClassParametersReference < BaseObject
      property :api_group, String
      property :kind, String
      property :name, String
      property :namespace, String
      property :scope, String
    end
  end
end
