$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "acts_as_rdfable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "acts_as_rdfable"
  spec.version     = ActsAsRDFable::VERSION
  spec.authors     = ["Matt Barnett"]
  spec.email       = ["matt@sixtyodd.com"]
  spec.homepage    = "http://thisisfake.com/asdf"
  spec.summary     = " Summary of ActsAsRDFable."
  spec.description = " Description of ActsAsRDFable."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'active_record', '~> 5.2.3'
  spec.add_dependency 'builder', '~> 2.0'
  spec.add_dependency 'tilt', '~>2.0.10'
  spec.add_development_dependency "sqlite3"
end
