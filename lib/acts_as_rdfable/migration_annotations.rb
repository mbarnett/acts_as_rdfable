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

  def add_rdf_table_annotation(table:, &configuration_block)
    return delete_table_annotation(table) if reverting?

    config = RdfConfig.new

    configuration_block.call(config)

    config.mapping.each do |column_name, rdf_predicate|
      annotation = RdfAnnotation.for_table(table).find_or_initialize_by(column: column_name)
      annotation.predicate = rdf_predicate.to_s
      annotation.save!
    end
  end

  def remove_rdf_table_annotation(table)
    irreversible! %Q(Cannot reverse deletion of RDF annotations for table "#{table}")
    delete_table_annotation(table)
  end

  def add_rdf_column_annotation(table, column, has_predicate:)
    return delete_column_annotation(table, column) if reverting?

    annotation = RdfAnnotation.for_table(table).find_or_initialize_by(column: column)
    annotation.predicate = has_predicate.to_s
    annotation.save!
  end

  def remove_rdf_column_annotation(table, column)
    irreversible! %Q(Cannot reverse deletion of RDF annotations for "#{table}"."#{column}")
    delete_column_annotation(table, column)
  end

  private

  def delete_table_annotation(table)
    RdfAnnotation.for_table(table).destroy_all
  end

  def delete_column_annotation(table, column)
    RdfAnnotation.for_table_column(table, column).destroy_all
  end

  def irreversible!(msg)
    raise ActiveRecord::IrreversibleMigration, msg if reverting?
  end
end
