module Sidir
  SIMULATORS_DIR = File.expand_path("~/Library/Application Support/iPhone Simulator")
  def self.find query=''
    query_components = query.split('/')

    items = if 0 == query.scan(/\//).count
      Path::SimulatorPath.find(SIMULATORS_DIR, query_components.first)
    else
      Path::ApplicationPath.find(query_components.first, query_components[1])
    end
    
    items_node = REXML::Element.new("items")
    items.each { |item| items_node << item.to_xml }
    REXML::Document.new << items_node
  end
end

require 'sidir/path'