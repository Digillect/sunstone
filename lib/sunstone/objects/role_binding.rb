module Sunstone
  module Objects
    class RoleBinding < ClusterRoleBinding
      api_version 'rbac.authorization.k8s.io/v1'

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
