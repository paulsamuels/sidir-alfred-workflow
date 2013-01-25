module Sidir
  def self.find query='', root_dir=File.expand_path("~/Library/Application Support/iPhone Simulator")        
    items_node = REXML::Element.new("items")
    ResultsFactory.results(root_dir, query).each { |item| items_node << item.to_xml }
    REXML::Document.new << items_node
  end
end

require 'sidir/results_factory'
require 'sidir/result_items'