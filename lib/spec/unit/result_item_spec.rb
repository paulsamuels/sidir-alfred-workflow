require 'support/spec_helper'
require 'sidir/result_items/result_item'

module Sidir
  describe ResultItem do
    subject(:result_item) { ResultItem.new }
    
    it { should respond_to :path, :path= }
    it { should respond_to :icon, :icon= }
    it { should respond_to :title, :title= }
    it { should respond_to :subtitle, :subtitle= }
    it { should respond_to :uid, :uid= }
    it { should respond_to :valid, :valid= }
    it { should respond_to :autocomplete, :autocomplete= }
    it { should respond_to :arg, :arg= }
    
    describe "to_xml" do
      context "with all attributes defined" do
        it "returns the correct xml fragment" do
          result_item.tap { |ri|
            ri.icon         = 'simulator_folder.png'
            ri.title        = '5.0'
            ri.subtitle     = 'Show 2 apps installed for 5.0 simulator'
            ri.uid          = 'sidir/5.0'
            ri.valid        = 'no'
            ri.autocomplete = '5.0/'
            ri.arg          = '5.0/'
          }
        
          expected = "<item arg='5.0/' autocomplete='5.0/' uid='sidir/5.0' valid='no'><title>5.0</title><subtitle>Show 2 apps installed for 5.0 simulator</subtitle><icon>simulator_folder.png</icon></item>"
          
          verify_xml expected, result_item.to_xml.to_s
        end
      end
      
      context "with optional values" do
        it "returns the correct xml fragment with no valid" do
          result_item.tap { |ri|
            ri.icon         = 'simulator_folder.png'
            ri.title        = '5.0'
            ri.subtitle     = 'Show 2 apps installed for 5.0 simulator'
            ri.uid          = 'sidir/5.0'
            ri.autocomplete = '5.0/'
            ri.arg          = '5.0/'
          }
        
          expected = "<item arg='5.0/' autocomplete='5.0/' uid='sidir/5.0'><title>5.0</title><subtitle>Show 2 apps installed for 5.0 simulator</subtitle><icon>simulator_folder.png</icon></item>"
          
          verify_xml expected, result_item.to_xml.to_s
        end

        it "returns the correct xml fragment with no autocomplete" do
          result_item.tap { |ri|
            ri.icon         = 'simulator_folder.png'
            ri.title        = '5.0'
            ri.subtitle     = 'Show 2 apps installed for 5.0 simulator'
            ri.uid          = 'sidir/5.0'
            ri.arg          = '5.0/'
          }
        
          expected = "<item arg='5.0/' uid='sidir/5.0'><title>5.0</title><subtitle>Show 2 apps installed for 5.0 simulator</subtitle><icon>simulator_folder.png</icon></item>"
          
          verify_xml expected, result_item.to_xml.to_s
        end
      end
    end
  end
end