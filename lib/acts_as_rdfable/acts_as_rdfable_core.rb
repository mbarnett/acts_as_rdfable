module ActsAsRdfable::ActsAsRdfableCore
  extend ActiveSupport::Concern

  class_methods do
    def acts_as_rdfable(formats: [])
      raise InvalidClassError unless self < ActiveRecord::Base
      raise InvalidArgumentError unless (formats.is_a?(Symbol) || formats.is_a?(Array))

      formats = [formats] if formats.is_a? Symbol
      formats.each { |format| ActsAsRdfable::Serializer.register_format_for_class(self, format: format) }

      define_method :rdf_annotations do
        self.singleton_class.rdf_annotations
      end

      define_method :rdf_annotation_for_attr do |attr|
        self.singleton_class.rdf_annotation_for_attr attr
      end

      define_method :serialize_metadata do |format:, into_document:|
        format = format.to_sym unless format.is_a?(Symbol)
        # Resolution needed for this due to new specs.
        # raise InvalidArgumentError unless self.singleton_class.supported_metadata_serialization_formats.include?(format)
        ActsAsRdfable::Serializer.serialize(instance: self, format: format, xml_doc: into_document)
      end

      define_singleton_method :rdf_annotations do
        RdfAnnotation.for_table(self.table_name)
      end

      define_singleton_method :rdf_annotation_for_attr do |attr|
        RdfAnnotation.for_table_column(self.table_name, attr)
      end

      define_singleton_method :supported_metadata_serialization_formats do
        formats
      end

    end
  end
end
