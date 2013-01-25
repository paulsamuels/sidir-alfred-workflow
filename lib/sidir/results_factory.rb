module Sidir
  class ResultsFactory
    def self.results(root_dir, query)
      new(root_dir, query).results
    end
    
    def initialize root_dir, query
      @root_dir, @query = root_dir, query
    end
    
    def results
      items = []
      Dir[search_meta_data.glob].each do |path|
        result_item = search_meta_data.klass.new(path, search_meta_data.query)
        items << result_item if result_item.valid_result?
      end
      
      if items.empty?
        items << NullResult.new(root_dir, '')
      end
      
      items
    end
    
    private
    
    attr_reader :root_dir, :query, :search_meta_data
    
    def search_meta_data
      @search_meta_data ||= begin
        if 0 == query.scan(/\//).count
          if query.length > 0 && !('0'..'9').include?(query[0,1])
            SearchMetaData.new(ApplicationResult, "#{root_dir}/**/Applications/*", query_components.first)
          else
            SearchMetaData.new(SimulatorResult, "#{root_dir}/*", query_components.first)
          end
        else
          SearchMetaData.new(SimulatorApplicationResult, "#{root_dir}/#{query_components.first}/Applications/*", query_components[1])
        end
      end
    end
    
    def query_components
      @query_components ||= query.split('/')
    end
  end
end

SearchMetaData = Struct.new(:klass, :glob, :query)