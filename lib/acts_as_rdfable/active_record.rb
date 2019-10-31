module ActiveRecord
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.send :include, ActsAsRDFable::ActsAsRDFableCore
    ActiveRecord::Migration::Current.send :include, ActsAsRDFable::MigrationAnnotations
  end
end
