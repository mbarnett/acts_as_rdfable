module ActsAsRdfable
  class Railtie < ::Rails::Railtie
    initializer :append_migrations do |app|
      unless app.root.to_s.match ActsAsRdfable.gem_root.to_s
        app.config.paths["db/migrate"] << ActsAsRdfable.migration_path
      end
    end
  end
end
