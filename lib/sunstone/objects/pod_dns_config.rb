require 'sunstone/objects/base_object'
require 'sunstone/objects/pod_dns_config_option'

module Sunstone
  module Objects
    class PodDNSConfig < BaseObject
      property :nameservers, Array, String
      property :options, Array, PodDNSConfigOption
      property :searches, Array, String

      def nameservers(*values)
        return @nameservers if values.empty?

        @nameservers.concat values
      end

      alias nameserver nameservers

      def option(name, value = nil, &block)
        option = PodDNSConfigOption.new(name, value)

        option.instance_eval(&block) if block_given?

        @options.push option

        option
      end

      def searches(*values)
        return @searches if values.empty?

        @searches.concat values
      end

      alias search searches
    end
  end
end
