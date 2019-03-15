require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class Toleration < BaseObject
      property :effect, String
      property :key, String
      property :operator, String
      property :toleration_seconds, Integer
      property :value, String
    end
  end
end
