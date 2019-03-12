require 'active_support/concern'

module Sunstone
  module Objects
    module PodTemplateExtensions
      extend ActiveSupport::Concern

      def pod_spec(&block)
        pod_template.spec.instance_eval(&block) if block_given?

        pod_template.spec
      end

      def container(name = :main, &block)
        pod_template.spec.container(name, &block)
      end

      def volumes
        yield pod_template.spec.volumes if block_given?

        pod_template.spec.volumes
      end
    end
  end
end
