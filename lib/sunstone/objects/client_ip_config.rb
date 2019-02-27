require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class ClientIPConfig < BaseObject
      property :timeout_seconds

      def empty?
        timeout_seconds.blank?
      end
    end
  end
end
