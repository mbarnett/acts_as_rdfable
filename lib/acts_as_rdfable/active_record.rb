module ActiveRecord
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.send :include, ActsAsRdfable::ActsAsRdfableCore
    ActiveRecord::Migration::Current.send :include, ActsAsRdfable::MigrationAnnotations
  end
end
