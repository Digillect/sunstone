module Sunstone
  module Objects
    class PodDnsConfig < BaseObject
      property :nameservers, Array, String
      property :options, BaseArray, PodDnsConfigOption
      property :searches, Array, String

      def nameservers(*values)
        return @nameservers if values.empty?

        @nameservers.concat values
      end

      alias nameserver nameservers

      def option(name, value = nil, &block)
        option = PodDnsConfigOption.new(name, value)

        option.instance_eval(&block) if block_given?

        @options << option

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
