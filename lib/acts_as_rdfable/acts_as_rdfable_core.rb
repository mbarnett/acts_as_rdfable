module ActsAsRdfable::ActsAsRdfableCore
  extend ActiveSupport::Concern

  class_methods do
    def acts_as_rdfable(&configuration_block)
      raise InvalidClassError unless self < ActiveRecord::Base

      define_method :rdf_annotations do
        RdfAnnotation.for_table(self.class.table_name)
      end

      define_method :rdf_annotation_for_attr do |attr|
        RdfAnnotation.for_table_column(self.class.table_name, attr)
      end
    end
  end
end
