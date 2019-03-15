require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class RollingUpdateStatefulSetStrategy < BaseObject
      property :partition, Integer
    end
  end
end
