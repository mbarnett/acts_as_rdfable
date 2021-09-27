module ActsAsRdfable
    # Configures global settings for ActsAsRdfable
    #   ActsAsRdfable.configure do |config|
    #     config.dump_changes = false
    #     config.dump_to_path = 'db/seeds/rdf_annotations.rb'
    #   end
    class << self
      def configure
        yield config
      end
  
      def config
        @_config ||= Config.new
      end
    end
  
    class Config
      attr_accessor :dump_changes, :dump_to_path
  
      def initialize
        @dump_changes = false
        @dump_to_path = 'db/seeds/rdf_annotations.rb'
      end
    end
  end