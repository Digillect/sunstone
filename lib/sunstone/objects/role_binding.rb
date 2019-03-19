require 'sunstone/objects/cluster_role_binding'

module Sunstone
  module Objects
    class RoleBinding < ClusterRoleBinding
      def initialize(name)
        super
      end

      def namespace(value = nil)
        metadata.namespace = value if value

        metadata.namespace
      end

      def role(name)
        @role_ref = RoleRef.new(name, :Role, 'rbac.authorization.k8s.io')
      end
    end
  end
end
