module Sunstone
  module Objects
    class HttpIngressRuleValue < BaseObject
      property :paths, BaseArray, HttpIngressPath

      def add_path(&block)
        path = HttpIngressPath.new

        path.instance_eval(&block) unless block.nil?

        @paths << path
      end
    end
  end
end
