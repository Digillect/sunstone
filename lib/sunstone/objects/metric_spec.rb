module Sunstone
  module Objects
    class MetricSpec < BaseObject
      property :external, ExternalMetricSource
      property :object, ObjectMetricSource
      property :pods, PodsMetricSource
      property :resource, ResourceMetricSource
      property :type, String

      def external(&block)
        @external ||= ExternalMetricSource.new

        @external.instance_eval(&block) if block_given?

        @external
      end

      def object(&block)
        @object ||= ObjectMetricSource.new

        if block_given?
          @type = 'Object'

          @object.instance_eval(&block)
        end

        @object
      end

      def pods(&block)
        @pods ||= PodsMetricSource.new

        if block_given?
          @type = 'Pods'

          @pods.instance_eval(&block)
        end

        @pods
      end

      def resource(&block)
        @resource ||= ResourceMetricSource.new

        if block_given?
          @type = 'Resource'

          @resource.instance_eval(&block)
        end

        @resource
      end
    end
  end
end
