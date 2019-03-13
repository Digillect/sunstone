require 'sunstone/version'

require 'active_support'
require 'active_support/core_ext'
require 'active_support/dependencies/autoload'

module Sunstone
  extend ActiveSupport::Autoload

  autoload :Release
  autoload :ValuesManager

  autoload_under :objects do
    eager_autoload do
      autoload :ClusterRoleBinding
      autoload :ConfigMap
      autoload :CronJob
      autoload :CustomResource
      autoload :DaemonSet
      autoload :Deployment
      autoload :Job
      autoload :Ingress
      autoload :PersistentVolumeClaim
      autoload :Pod
      autoload :RoleBinding
      autoload :Secret
      autoload :Service
      autoload :StatefulSet
    end
  end

  autoload_under :formatters do
    eager_autoload do
      autoload :JsonFormatter
      autoload :YamlFormatter
    end
  end

  release = Sunstone::Release.new
  Object.const_set :R, release
  Object.const_set :Release, release

  def self.error(message, exit_code = 1)
    puts message

    exit exit_code
  end
end
