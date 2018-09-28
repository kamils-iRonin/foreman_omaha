module ForemanOmaha
  module Charts
    class VersionDistribution
      attr_accessor :hosts

      def initialize(hosts = nil)
        @hosts = hosts || Host.authorized(:view_hosts, Host).joins(:omaha_facet)
      end

      def query
        hosts.group(:version).count
      end

      def to_chart_data
        query.map { |version, count| [version, count] }.to_json
      end
    end
  end
end
