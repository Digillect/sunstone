module Sunstone
  module Objects
    class VolumeArray < BaseArray
      def config_map(volume_name, *args, &block)
        keys_and_paths = args.extract_options!
        config_map_name ||= args.first || __root.metadata.name

        raise 'ConfigMap name must be specified or scope must be active' if config_map_name.blank?

        source = ConfigMapVolumeSource.new config_map_name

        keys_and_paths.each_pair do |key, path|
          source.add_item key, path
        end

        add_volume volume_name, source, &block
      end

      def empty_dir(volume_name, size_limit: nil, in_memory: false, &block)
        source = EmptyDirVolumeSource.new size_limit, in_memory ? 'Memory' : nil

        add_volume volume_name, source, &block
      end

      def host_path(volume_name, path, type: nil, &block)
        source = HostPathVolumeSource.new path, type

        add_volume volume_name, source, &block
      end

      def nfs(volume_name, server, path, readonly: nil, &block)
        source = NfsVolumeSource.new server, path, readonly

        add_volume volume_name, source, &block
      end

      def persistent_volume_claim(volume_name, claim_name, readonly: nil, &block)
        source = PersistentVolumeClaimVolumeSource.new claim_name, readonly

        add_volume volume_name, source, &block
      end

      alias pvc persistent_volume_claim

      def secret(volume_name, *args, &block)
        keys_and_paths = args.extract_options!
        secret_name ||= args.first || __root.metadata.name

        raise 'Secret name must be specified or scope must be active' if secret_name.blank?

        source = SecretVolumeSource.new secret_name

        keys_and_paths.each_pair do |key, path|
          source.add_item key, path
        end

        add_volume volume_name, source, &block
      end

      private

      def add_volume(volume_name, source, &block)
        source.instance_eval(&block) unless block.nil?

        volume = Volume.new volume_name, source

        self << volume

        volume
      end
    end
  end
end
