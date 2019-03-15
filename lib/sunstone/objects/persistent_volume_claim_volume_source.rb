require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class PersistentVolumeClaimVolumeSource < BaseObject
      property :claim_name, String
      property :readonly, TrueClass, serialized_name: 'readOnly'

      def initialize(claim_name, readonly = nil)
        super()

        @claim_name = claim_name
        @readonly = readonly
      end
    end
  end
end
