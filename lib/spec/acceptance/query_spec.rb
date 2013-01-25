require 'support/spec_helper'
require 'sidir'

module Sidir
  describe "Sidir::find" do
    context "an empty search" do
      it "returns all the simulators as items" do
        expected = "<items><item arg='#{MOCK_DIR}/5.0/' autocomplete='5.0/' uid='sidir/5.0' valid='no'><title>5.0</title><subtitle>Show 2 apps installed for 5.0 simulator</subtitle><icon>simulator_folder.png</icon></item><item arg='#{MOCK_DIR}/5.1/' autocomplete='5.1/' uid='sidir/5.1' valid='no'><title>5.1</title><subtitle>Show 1 app installed for 5.1 simulator</subtitle><icon>simulator_folder.png</icon></item><item arg='#{MOCK_DIR}/6.0/' autocomplete='6.0/' uid='sidir/6.0' valid='no'><title>6.0</title><subtitle>Show 2 apps installed for 6.0 simulator</subtitle><icon>simulator_folder.png</icon></item></items>"
        
        verify_xml_with_query expected, ''
      end
    end
    
    context "a correct simulator search" do
      it "returns the single app item" do
        expected = "<items><item arg='#{MOCK_DIR}/5.0/Applications/9FD41458-5A94-499C-AD43-16CC119508DD' uid='sidir/9FD41458-5A94-499C-AD43-16CC119508DD'><title>alpha</title><subtitle>Show alpha in finder</subtitle><icon>app_folder.png</icon></item><item arg='#{MOCK_DIR}/5.0/Applications/A95D3D31-C0E0-4CA8-BBC3-D724659D6F29' uid='sidir/A95D3D31-C0E0-4CA8-BBC3-D724659D6F29'><title>beta</title><subtitle>Show beta in finder</subtitle><icon>app_folder.png</icon></item></items>"
        
        verify_xml_with_query expected, '5.0/'
      end
    end
    
    context "a non existant app searched" do
      it "returns the default item" do
        expected = "<items><item arg='#{MOCK_DIR}' uid='sidir/show_all'><title>No apps found</title><subtitle>Open simulator directory</subtitle><icon>logo.png</icon></item></items>"
        
        verify_xml_with_query expected, '5.0/q'
      end
    end
    
    context "a partial simulator match" do
      it "narrows down the results to the two 5.x sims" do
        expected = "<items><item arg='#{MOCK_DIR}/5.0/' autocomplete='5.0/' uid='sidir/5.0' valid='no'><title>5.0</title><subtitle>Show 2 apps installed for 5.0 simulator</subtitle><icon>simulator_folder.png</icon></item><item arg='#{MOCK_DIR}/5.1/' autocomplete='5.1/' uid='sidir/5.1' valid='no'><title>5.1</title><subtitle>Show 1 app installed for 5.1 simulator</subtitle><icon>simulator_folder.png</icon></item></items>"
        
        verify_xml_with_query expected, '5.'
      end
      
      it "narrows down the results to the two 5.x sims" do
        expected = "<items><item arg='#{MOCK_DIR}/5.0/' autocomplete='5.0/' uid='sidir/5.0' valid='no'><title>5.0</title><subtitle>Show 2 apps installed for 5.0 simulator</subtitle><icon>simulator_folder.png</icon></item><item arg='#{MOCK_DIR}/5.1/' autocomplete='5.1/' uid='sidir/5.1' valid='no'><title>5.1</title><subtitle>Show 1 app installed for 5.1 simulator</subtitle><icon>simulator_folder.png</icon></item></items>"
        
        verify_xml_with_query expected, '5'
      end
    end
    
    context "a partial app match" do
      it "only returns matching apps" do
        expected = "<items><item arg='#{MOCK_DIR}/5.0/Applications/9FD41458-5A94-499C-AD43-16CC119508DD' uid='sidir/9FD41458-5A94-499C-AD43-16CC119508DD'><title>alpha</title><subtitle>Show alpha in finder</subtitle><icon>app_folder.png</icon></item></items>"
                
        verify_xml_with_query expected, '5.0/a'
      end
    end

    context "a partial app match with no simulator" do
      it "only returns matching apps" do
        expected = "<items><item arg='#{MOCK_DIR}/5.0/Applications/9FD41458-5A94-499C-AD43-16CC119508DD' uid='sidir/9FD41458-5A94-499C-AD43-16CC119508DD'><title>5.0/alpha</title><subtitle>Show alpha in finder</subtitle><icon>app_folder.png</icon></item><item arg='#{MOCK_DIR}/5.1/Applications/4512410F-3B50-44CE-959B-9293F21B363D' uid='sidir/4512410F-3B50-44CE-959B-9293F21B363D'><title>5.1/alpha</title><subtitle>Show alpha in finder</subtitle><icon>app_folder.png</icon></item></items>"
        
        verify_xml_with_query expected, 'a'
      end
    end
    
    def verify_xml_with_query expected, query
      actual = Sidir::find(query, MOCK_DIR).to_s
      # puts expected, actual
      # puts
      # puts
      verify_xml expected, actual
    end
  end
end