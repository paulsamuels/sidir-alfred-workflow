require 'rexml/document'

module Sidir
  class ResultItem
    attr_accessor :path, :icon, :title, :subtitle, :uid, :valid, :autocomplete, :arg
    
    def initialize
      yield self if block_given?
    end
    
    def to_xml
      new_item = REXML::Element.new('item')
      new_item.add_attributes(attributes)

      %w(title subtitle icon).each do |key|
        REXML::Element.new(key, new_item).text = self.send key
      end

      new_item
    end
    
    private
    
    def attributes
      attributes = { 'uid' => uid, 'arg' => arg }
      attributes['valid']        = valid if valid
      attributes['autocomplete'] = autocomplete if autocomplete 
      attributes
    end
  end
end