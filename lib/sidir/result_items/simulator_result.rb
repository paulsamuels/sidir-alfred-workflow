module Sidir
  class SimulatorResult < PathResult    
    def initialize path, query
      super
      self.uid          = "sidir/#{title}"
      self.valid        = 'no'
      self.icon         = 'simulator_folder.png'
      self.autocomplete = "#{title}/"
      self.arg          = arg_path
    end
    
    def title
      File.basename(path)
    end
    
    def subtitle
      "Show #{app_count} app#{'s' unless app_count == 1 } installed for #{title} simulator"
    end
    
    def valid_result?
      app_count > 0 && (query.nil? || title =~ %r!^#{query}!i)
    end
    
    private
    
    def app_count
      Dir["#{path}/Applications/*"].count
    end
    
    def arg_path
      "#{path}/"
    end
  end
end