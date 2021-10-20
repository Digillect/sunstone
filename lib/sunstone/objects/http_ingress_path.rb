module Sunstone
  module Objects
    class HttpIngressPath < BaseObject
      property :backend, IngressBackend
      property :path, String
      property :path_type, String, valid_values: %w[Exact Prefix ImplementationSpecific].freeze
    end
  end
end
