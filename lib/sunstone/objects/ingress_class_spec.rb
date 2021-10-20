require 'sunstone/objects/base_object'
require 'sunstone/objects/ingress_class_parameters_reference'

module Sunstone
  module Objects
    class IngressClassSpec < BaseObject
      property :controller, String
      property :parameters, IngressClassParametersReference
    end
  end
end
