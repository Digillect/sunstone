require 'sunstone/objects/config_map_or_secret'

module Sunstone
  module Objects
    class ConfigMap < ConfigMapOrSecret
      def initialize(name)
        super
      end
    end
  end
end

R.register_resource :config_map, Sunstone::Objects::ConfigMap
