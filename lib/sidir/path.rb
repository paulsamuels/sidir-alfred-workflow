require 'rexml/document'

module Sidir
  module Path
    class AbstractPath
      attr_reader :path, :title

      def self.find root, query
        paths = []
        Dir[glob(root)].each do |path|
          path = self.new(path)
          paths << path if path.valid? query
        end
        paths << RootPath.new(SIMULATORS_DIR) if paths.empty?
        paths
      end

      def initialize path
        @path = path
      end

      def basename
        File.basename path
      end

      def to_xml
        new_item = REXML::Element.new('item')
        new_item.add_attributes(attributes)

        %w(title subtitle icon).each do |key|
          REXML::Element.new(key, new_item).text = self.send key
        end

        new_item
      end
    end
  end
end

require 'sidir/path/root_path'
require 'sidir/path/simulator_path'
require 'sidir/path/application_path'