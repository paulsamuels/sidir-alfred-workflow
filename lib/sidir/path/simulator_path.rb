module Sidir
  module Path
    class SimulatorPath < AbstractPath
      def self.glob base
        "#{base}/*"
      end
      
      def title
        basename
      end
      
      def subtitle
        "Show #{app_count} app#{'s' unless app_count == 1 } installed for #{title} simulator"
      end
  
      def valid? query
        app_count > 0 && (query.nil? || title =~ %r!^#{query}!i)
      end
  
      def icon
        'simulator_folder.png'
      end
  
      def attributes
        {
          "uid"          => "sidir/#{basename}",
          "valid"        => "no",
          "autocomplete" => "#{basename}/",
          "arg"          => "#{basename}/",
        }
      end
  
      private
  
      def app_count
        Dir["#{path}/Applications/*"].count
      end
    end
  end
end