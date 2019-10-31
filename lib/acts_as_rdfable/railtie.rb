module ActsAsRDFable
  class Railtie < ::Rails::Railtie
    initializer :append_migrations do |app|
      unless app.root.to_s.match ActsAsRDFable.gem_root.to_s
        app.config.paths["db/migrate"] << ActsAsRDFable.migration_path
      end
    end
  end
end
