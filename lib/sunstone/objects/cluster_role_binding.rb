require 'sunstone/objects/kubernetes_object'
require 'sunstone/objects/role_ref'
require 'sunstone/objects/subject'

module Sunstone
  module Objects
    class ClusterRoleBinding < KubernetesObject
      property :role_ref, RoleRef, initialize: false
      property :subjects, Array, Subject

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
    end
  end
end
