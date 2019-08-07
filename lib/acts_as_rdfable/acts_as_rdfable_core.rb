module ActsAsRdfable::ActsAsRdfableCore
  extend ActiveSupport::Concern

  class RdfConfig
    attr_accessor :mapping

    def initialize
      @mapping = {}
    end

    def add_mapping_option(attr)
      self.define_singleton_method(attr) do |has_predicate:|
        mapping[attr] = has_predicate
      end
    end
  end

  class_methods do
    def acts_as_rdfable(&configuration_block)
      raise InvalidClassError unless self < ActiveRecord::Base

      config = RdfConfig.new
      self.column_names.each do |name|
        config.add_mapping_option(name)
      end

      configuration_block.call(config)
      config.mapping.each do |column_name, rdf_predicate|
        annotation = RdfAnnotation.for_table(self.table_name).find_or_initialize_by(column: column_name)
        annotation.predicate = rdf_predicate.to_s
        annotation.save!
      end
    end
  end
end
