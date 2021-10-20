module Sunstone
  module Objects
    class IngressClassSpec < BaseObject
      property :controller, String
      property :parameters, IngressClassParametersReference
    end
  end
end
