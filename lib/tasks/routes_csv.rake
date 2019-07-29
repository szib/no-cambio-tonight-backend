namespace :routes do
  desc 'Print out all defined routes in CSV format.'
  task :csv => :environment do

    class CSVFormatter
      def initialize
        @buffer = []
      end

      def result
        @buffer.join("\n")
      end

      def section_title(title)
        @buffer << "\n#{title}:"
      end

      def section(routes)
        routes.map do |r|
          @buffer << "#{r[:name]},#{r[:verb]},#{r[:path]},#{r[:reqs]}"
          # @buffer << "#{r[:verb]} #{r[:path]}"
        end
      end

      def header(routes)
        @buffer << 'Prefix,Verb,URI Pattern,Controller#Action'
      end

      def no_routes
        @buffer << <<-MESSAGE.strip_heredoc
          You don't have any routes defined!
          Please add some routes in config/routes.rb.
          For more information about routes, see the Rails guide: http://guides.rubyonrails.org/routing.html.
        MESSAGE
      end

    end

    all_routes = Rails.application.routes.routes
    require 'action_dispatch/routing/inspector'
    inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
    # puts inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, ENV['CONTROLLER'])
    puts inspector.format(CSVFormatter.new, ENV['CONTROLLER'])
  end
end