class CreateRdfAnnotationsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :rdf_annotations do |t|
      t.string :table
      t.string :column
      t.string :predicate

      t.timestamps
    end
  end
end
