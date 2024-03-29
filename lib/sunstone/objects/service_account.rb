module Sunstone
  module Objects
    class ServiceAccount < KubernetesObject
      api_version 'v1'

      property :automount_service_account_token, TrueClass
      property :image_pull_secrets, BaseArray, LocalObjectReference
      property :secrets, BaseArray, ObjectReference

      def image_pull_secrets(*names)
        return @image_pull_secrets if names.empty?

        names.each do |name|
          @image_pull_secrets << LocalObjectReference.new(name)
        end

        @image_pull_secrets
      end

      alias image_pull_secret image_pull_secrets

      def add_secret(name, namespace = nil, &block)
        secret = ObjectReference.new name, namespace

        secret.instance_eval(&block) unless block.nil?

        secret
      end
    end
  end
end
