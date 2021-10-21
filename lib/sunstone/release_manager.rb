module Sunstone
  class ReleaseManager
    DEFAULT_VERSION = '1.21'.freeze
    API_VERSION_MAP = {
      '1.21': {
        cluster_role: Sunstone::Objects::ClusterRole,
        cluster_role_binding: Sunstone::Objects::ClusterRoleBinding,
        config_map: Sunstone::Objects::ConfigMap,
        cron_job: Sunstone::Objects::CronJob,
        daemon_set: Sunstone::Objects::DaemonSet,
        deployment: Sunstone::Objects::Deployment,
        horizontal_pod_autoscaler: Sunstone::Objects::HorizontalPodAutoscaler,
        ingress: Sunstone::Objects::Ingress,
        ingress_class: Sunstone::Objects::IngressClass,
        job: Sunstone::Objects::Job,
        persistent_volume_claim: Sunstone::Objects::PersistentVolumeClaim,
        pod: Sunstone::Objects::Pod,
        role: Sunstone::Objects::Role,
        role_binding: Sunstone::Objects::RoleBinding,
        secret: Sunstone::Objects::Secret,
        service: Sunstone::Objects::Service,
        service_account: Sunstone::Objects::ServiceAccount,
        stateful_set: Sunstone::Objects::StatefulSet
      },
      '1.19': {
        cluster_role: Sunstone::Objects::ClusterRole,
        cluster_role_binding: Sunstone::Objects::ClusterRoleBinding,
        config_map: Sunstone::Objects::ConfigMap,
        cron_job: Sunstone::Objects::CronJobBatchV1beta1,
        daemon_set: Sunstone::Objects::DaemonSet,
        deployment: Sunstone::Objects::Deployment,
        horizontal_pod_autoscaler: Sunstone::Objects::HorizontalPodAutoscaler,
        ingress: Sunstone::Objects::Ingress,
        ingress_class: Sunstone::Objects::IngressClass,
        job: Sunstone::Objects::Job,
        persistent_volume_claim: Sunstone::Objects::PersistentVolumeClaim,
        pod: Sunstone::Objects::Pod,
        role: Sunstone::Objects::Role,
        role_binding: Sunstone::Objects::RoleBinding,
        secret: Sunstone::Objects::Secret,
        service: Sunstone::Objects::Service,
        service_account: Sunstone::Objects::ServiceAccount,
        stateful_set: Sunstone::Objects::StatefulSet
      }
    }.freeze

    def default_version
      DEFAULT_VERSION
    end

    def available_versions
      API_VERSION_MAP.keys.map(&:to_s)
    end

    def create_release(version)
      version ||= DEFAULT_VERSION

      map = API_VERSION_MAP[version.to_sym]

      release = Release.new

      map.each_pair do |key, klass|
        release.register_resource key, klass
      end

      release
    end
  end
end
