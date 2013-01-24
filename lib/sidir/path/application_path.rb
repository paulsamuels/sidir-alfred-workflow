module Sidir
  module Path
    class ApplicationPath < AbstractPath      
      def self.glob base
        "#{SIMULATORS_DIR}/#{base}/Applications/*"
      end
  
      def title
        File.basename Dir["#{path}/*.app"].first, '.app'
      end
  
      def subtitle
        "Show #{title} in finder"
      end
  
      def valid? query
        query.nil? || title =~ %r!^#{query}!i
      end
  
      def icon
        'app_folder.png'
      end
  
      def attributes
        { "uid" => "sidir/#{basename}", "arg" => path }
      end
    end
  end
end