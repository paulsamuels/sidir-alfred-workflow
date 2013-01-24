module Sidir
  module Path
    class RootPath < AbstractPath        
      def title
        'No apps found'
      end
  
      def subtitle
        "Open simulator directory"
      end
  
      def icon
        'logo.png'
      end
  
      def attributes
        { "uid" => "sidir/show_all", "arg" => path }
      end
    end
  end
end