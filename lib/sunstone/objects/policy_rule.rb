module Sunstone
  module Objects
    class PolicyRule < BaseObject
      property :api_groups, Array, String
      property :non_resource_urls, Array, String, serialized_name: :nonResourceURLs
      property :resource_names, Array, String
      property :resources, Array, String
      property :verbs, Array, String

      def api_groups(*values)
        return @api_groups if values.empty?

        @api_groups.concat values.map(&:to_s)
      end

      alias api_group api_groups

      def non_resource_urls(*values)
        return @non_resource_urls if values.empty?

        @non_resource_urls.concat values.map(&:to_s)
      end

      alias non_resource_url non_resource_urls

      def resource_names(*values)
        return @resource_names if values.empty?

        @resource_names.concat values.map(&:to_s)
      end

      alias resource_name resource_names

      def resources(*values)
        return @resources if values.empty?

        @resources.concat values.map(&:to_s)
      end

      alias resource resources

      def verbs(*values)
        return @verbs if values.empty?

        @verbs.concat values.map(&:to_s)
      end

      alias verb verbs
    end
  end
end
