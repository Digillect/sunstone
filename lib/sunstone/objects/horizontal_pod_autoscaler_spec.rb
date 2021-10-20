module Sunstone
  module Objects
    class HorizontalPodAutoscalerSpec < BaseObject
      property :max_replicas, Integer
      property :metrics, BaseArray, MetricSpec
      property :min_replicas, Integer
      property :scale_target_ref, CrossVersionObjectReference

      def add_external_metric(&block)
        metric = MetricSpec.new

        metric.external(&block)

        @metrics << metric
      end

      def add_object_metric(&block)
        metric = MetricSpec.new

        metric.object(&block)

        @metrics << metric
      end

      def add_pods_metric(&block)
        metric = MetricSpec.new

        metric.pods(&block)

        @metrics << metric
      end

      def add_resource_metric(&block)
        metric = MetricSpec.new

        metric.resource(&block)

        @metrics << metric
      end
    end
  end
end
