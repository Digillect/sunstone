require 'active_support/concern'

module Sunstone
  module Objects
    module PodTemplateExtensions
      extend ActiveSupport::Concern

      def pod_spec(&block)
        pod_template.spec(&block)
      end

      def container(name = :main, &block)
        pod_template.spec.container(name, &block)
      end

      def volumes(&block)
        pod_template.spec.volumes(&block)
      end
    end
  end
end
