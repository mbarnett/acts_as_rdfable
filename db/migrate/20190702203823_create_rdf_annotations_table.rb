class CreateRDFAnnotationsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :rdf_annotations do |t|
      t.string :table
      t.string :column
      t.string :predicate
      # the qualified name lookup is shockingly expensive in the RDF gem: https://github.com/ruby-rdf/rdf/blob/develop/lib/rdf/model/uri.rb#L624-L645
      # basically every call causes it to re-iterate and compare the URI of the URI's Vocab against every existing vocab with
      # zero attempt to cache results.
      #
      # Since this is going to be in the hot loop for serialization, we're going to cache this at annotation time rather than
      # call qname/pname during serialization
      t.string :namespace_prefix
      t.string :qualified_name
      # Similar to above, we're going to cache this rather than grovel through and do string comparisons against existing
      # Vocabs at serialization time
      t.string :namespace
      t.timestamps
    end
  end
end
