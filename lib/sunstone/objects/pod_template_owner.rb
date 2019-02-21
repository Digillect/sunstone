require 'active_support/concern'

module Sunstone
  module Objects
    module PodTemplateOwner
      extend ActiveSupport::Concern

      def pod_template
        yield spec.template if block_given?

        spec.template
      end
    end
  end
end
