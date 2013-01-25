module Sidir
  class NullResult < PathResult    
    def initialize path, query
      super
      self.title    = 'No apps found'
      self.subtitle = 'Open simulator directory'
      self.icon     = 'logo.png'
      self.uid      = 'sidir/show_all'
      self.arg      = path
    end
  end
end