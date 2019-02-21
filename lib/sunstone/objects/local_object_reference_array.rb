require 'sunstone/objects/local_object_reference'

module Sunstone
  module Objects
    class LocalObjectReferenceArray < Array
      # TODO: Replace with add
      def push(name)
        super LocalObjectReference.new(name)
      end

      alias add push
    end
  end
end
