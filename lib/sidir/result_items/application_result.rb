module Sidir
  class ApplicationResult < SimulatorApplicationResult
    def initialize path, query
      super
      self.uid  = "sidir/#{basename}"
      self.icon = 'app_folder.png'
      self.arg  = path
    end
    
    def title
      prefix = File.basename(File.expand_path('../../', path))
      "#{prefix}/#{app_name}"
    end
    
    def subtitle
      "Show #{app_name} in finder"
    end
    
    def valid_result?
      query.nil? || app_name =~ %r!^#{query}!i
    end
    
    private
    
    def basename
      File.basename(path)
    end
    
    def app_name
      File.basename(Dir["#{path}/*.app"].first, '.app')
    end
  end
end