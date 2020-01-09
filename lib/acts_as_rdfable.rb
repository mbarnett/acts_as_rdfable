require 'active_record'
require "acts_as_rdfable/railtie"
require 'acts_as_rdfable/acts_as_rdfable_core'
require 'acts_as_rdfable/migration_annotations'
require 'acts_as_rdfable/active_record'
require 'acts_as_rdfable/rdf_annotation'

module ActsAsRdfable

  class InvalidClassError < StandardError; end
  def gem_root
    File.dirname __dir__
  end

  def migration_path
    File.join gem_root, 'db/migrate'
  end

  module_function :gem_root, :migration_path

  def self.add_annotation_bindings!(instance)
    instance.singleton_class.class_eval do
      include ActsAsRdfable::ActsAsRdfableCore

      acts_as_rdfable
    end
  end
end
