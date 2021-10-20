module Sunstone
  class ReleaseManager
    def self.create_and_publish_release
      release_manager = ReleaseManager.new
      release = release_manager.create_release

      Object.const_set :R, release
      Object.const_set :Release, release

      release
    end

    def create_release
      release = Release.new

      release.register_resource :cluster_role, Sunstone::Objects::ClusterRole
      release.register_resource :cluster_role_binding, Sunstone::Objects::ClusterRoleBinding
      release.register_resource :config_map, Sunstone::Objects::ConfigMap
      release.register_resource :cron_job, Sunstone::Objects::CronJob
      release.register_resource :daemon_set, Sunstone::Objects::DaemonSet
      release.register_resource :deployment, Sunstone::Objects::Deployment
      release.register_resource :horizontal_pod_autoscaler, Sunstone::Objects::HorizontalPodAutoscaler
      release.register_resource :ingress, Sunstone::Objects::Ingress
      release.register_resource :ingress_class, Sunstone::Objects::IngressClass
      release.register_resource :job, Sunstone::Objects::Job
      release.register_resource :persistent_volume_claim, Sunstone::Objects::PersistentVolumeClaim
      release.register_resource :pod, Sunstone::Objects::Pod
      release.register_resource :role, Sunstone::Objects::Role
      release.register_resource :role_binding, Sunstone::Objects::RoleBinding
      release.register_resource :secret, Sunstone::Objects::Secret
      release.register_resource :service, Sunstone::Objects::Service
      release.register_resource :service_account, Sunstone::Objects::ServiceAccount
      release.register_resource :stateful_set, Sunstone::Objects::StatefulSet

      release
    end
  end
end
