require_relative "lib/validates_unique_values_on_association/version"

Gem::Specification.new do |spec|
  spec.name = "validates_unique_values_on_association"
  spec.version = ValidatesUniqueValuesOnAssociation::VERSION
  spec.authors = ["kaspernj"]
  spec.email = ["k@spernj.org"]
  spec.homepage = "https://github.com/kaspernj/validates_unique_values_on_association"
  spec.summary = "Validate if an association has unique values on a specific attribute."
  spec.description = "Validate if an association has unique values on a specific attribute."
  spec.license = "MIT"
  spec.metadata = {"rubygems_mfa_required" => "true"}
  spec.required_ruby_version = ">= 2.7"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kaspernj/validates_unique_values_on_association"
  spec.metadata["changelog_uri"] = "https://github.com/kaspernj/validates_unique_values_on_association"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 6.0.0"
end
