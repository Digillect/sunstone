require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class Toleration < BaseObject
      property :effect
      property :key
      property :operator
      property :toleration_seconds
      property :value
    end
  end
end
