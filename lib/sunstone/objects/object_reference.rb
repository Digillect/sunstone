require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class ObjectReference < BaseObject
      property :name, String
      property :namespace, String
      property :api_version, String
      property :kind, String
      property :field_path, String
      property :resource_version, String
      property :uid, String

      def initialize(name = nil, namespace = nil)
        super()

        return if name.blank?

        if namespace.blank?
          namespace_and_name = name.split '/'

          if namespace_and_name.length > 1
            @namespace = namespace_and_name[0]
            @name = namespace_and_name[1]
          else
            @name = namespace_and_name[0]
          end
        else
          @namespace = namespace
          @name = name
        end
      end
    end
  end
end
