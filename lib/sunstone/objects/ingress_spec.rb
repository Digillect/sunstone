module Sunstone
  module Objects
    class IngressSpec < BaseObject
      property :default_backend, IngressBackend
      property :ingress_class_name, String
      property :tls, BaseArray, IngressTls
      property :rules, BaseArray, IngressRule
    end
  end
end
