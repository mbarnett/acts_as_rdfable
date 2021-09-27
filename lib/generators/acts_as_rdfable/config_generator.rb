module ActsAsRdfable
  module Generators
    # rails g acts_as_rdfable:config
    class ConfigGenerator < Rails::Generators::Base # :nodoc:
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      desc "Copies ActsAsRdfable configuration file to your application's initializer directory."

      def copy_config_file
        template 'acts_as_rdfable_template.rb', 'config/initializers/acts_as_rdfable.rb'
      end
    end
  end
end