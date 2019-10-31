class RDFAnnotation < ActiveRecord::Base
  validates :table, presence: true
  validates :column, presence: true
  validates :predicate, presence: true

  scope :for_table, ->(table_name) { where(table: table_name) }
  scope :for_table_column, ->(table_name, column_name) { for_table(table_name).where(column: column_name) }
end
