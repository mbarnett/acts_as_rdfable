module ActiveRecord
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.send :include, ActsAsRdfable::ActsAsRdfableCore
  end
end
