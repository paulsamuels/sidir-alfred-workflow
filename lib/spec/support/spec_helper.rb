$:.<< File.expand_path '../../../', __FILE__
require 'lorax'

MOCK_DIR = File.expand_path('../MockSimDir', __FILE__)

def verify_xml expected, actual
  Lorax::Signature.new(Nokogiri::XML(expected).root).signature.should eq(Lorax::Signature.new(Nokogiri::XML(actual).root).signature)
end