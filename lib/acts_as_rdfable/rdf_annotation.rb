class RdfAnnotation < ActiveRecord::Base
  validates :table, presence: true
  validates :column, presence: true
  validates :predicate, presence: true

  scope :for_table, ->(table_name) { where(table: table_name) }
end
