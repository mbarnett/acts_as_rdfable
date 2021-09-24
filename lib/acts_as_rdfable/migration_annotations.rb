require 'seed_dump'

module ActsAsRdfable::MigrationAnnotations
  extend ActiveSupport::Concern

  class RdfConfig
    attr_accessor :mapping

    def initialize
      @mapping = {}
    end

    def method_missing(name, *args, &block)
      raise ArgumentError, 'Must specify a predicate' unless args.count == 1
      arg = args.first
      raise ArgumentError, "Usage: t.#{name} has_predicate: foo" unless arg.is_a?(Hash) && arg.key?(:has_predicate)
      mapping[name] = arg[:has_predicate]
    end
  end

  def add_rdf_table_annotations(for_table:, &configuration_block)
    return delete_table_annotations(for_table) if reverting?

    config = RdfConfig.new

    configuration_block.call(config)

    config.mapping.each do |column_name, rdf_predicate|
      annotation = RdfAnnotation.for_table(for_table).find_or_initialize_by(column: column_name)
      annotation.predicate = rdf_predicate.to_s
      annotation.save!
    end

    dump_rdf_annotations
  end

  def remove_rdf_table_annotations(table)
    irreversible! %Q(Cannot reverse deletion of RDF annotations for table "#{table}")
    delete_table_annotations(table)

    dump_rdf_annotations
  end

  def add_rdf_column_annotation(table, column, has_predicate:)
    return delete_column_annotation(table, column) if reverting?

    annotation = RdfAnnotation.for_table(table).find_or_initialize_by(column: column)
    annotation.predicate = has_predicate.to_s
    annotation.save!

    dump_rdf_annotations
  end

  def remove_rdf_column_annotation(table, column)
    irreversible! %Q(Cannot reverse deletion of RDF annotations for "#{table}"."#{column}")
    delete_column_annotation(table, column)

    dump_rdf_annotations
  end

  private

  def delete_table_annotations(table)
    RdfAnnotation.for_table(table).destroy_all
  end

  def delete_column_annotation(table, column)
    RdfAnnotation.for_table_column(table, column).destroy_all
  end

  def irreversible!(msg)
    raise ActiveRecord::IrreversibleMigration, msg if reverting?
  end

  def dump_rdf_annotations
    SeedDump.dump(RdfAnnotation, file: ActsAsRdfable.config.dump_to_path) if ActsAsRdfable.config.dump_changes
  end
end
