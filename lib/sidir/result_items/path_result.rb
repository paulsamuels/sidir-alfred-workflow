module Sidir
  class PathResult < ResultItem
    attr_accessor :path, :query
    
    def initialize path, query
      self.path  = path
      self.query = query
    end
  end
end
