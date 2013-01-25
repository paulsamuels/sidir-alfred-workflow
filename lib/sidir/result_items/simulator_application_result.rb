module Sidir
  class SimulatorApplicationResult < PathResult    
    def initialize path, query
      super
      self.uid  = "sidir/#{basename}"
      self.icon = 'app_folder.png'
      self.arg  = path
    end
    
    def title
      File.basename(Dir["#{path}/*.app"].first, '.app')
    end
    
    def subtitle
      "Show #{title} in finder"
    end
    
    def valid_result?
      query.nil? || title =~ %r!^#{query}!i
    end
    
    private
    
    def basename
      File.basename(path)
    end
  end
end