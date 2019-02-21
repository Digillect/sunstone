require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/role_ref'
require 'sunstone/objects/subject'

module Sunstone
  module Objects
    class ClusterRoleBinding < KubernetesObject
      attr_reader :role_ref, :subjects

      def initialize(name)
        super

        @subjects = []
      end

      def api_version
        'rbac.authorization.k8s.io/v1'
      end

      def cluster_role(name)
        @role_ref = RoleRef.new(name, :ClusterRole, 'rbac.authorization.k8s.io')
      end

      def add_user(name)
        @subjects << Subject.new(:User, name)
      end

      def add_group(name)
        @subjects << Subject.new(:Group, name)
      end

      def add_service_account(name, namespace)
        @subjects << Subject.new(:ServiceAccount, name, namespace)
      end

      def to_hash
        result = super

        result[:roleRef] = @role_ref.to_hash
        result[:subjects] = @subjects.map(&:to_hash)

        result
      end
    end
  end
end

R.register_resource :cluster_role_binding, Sunstone::Objects::ClusterRoleBinding
