# frozen_string_literal: true

require_relative "lib/urbooks_server/version"

Gem::Specification.new do |spec|
  spec.name = "urbooks_server"
  spec.version = URbooksServer::VERSION
  spec.authors = ["ohzqq"]
  spec.email = ["iamchurkey@gmail.com"]

  spec.summary = "An API for getting metadata from Calibre Databases."
  spec.homepage = "https://github.com/ohzqq/urbooks-server"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://github.com/ohzqq/urbooks-server"

  spec.metadata["homepage_uri"] = "https://github.com/ohzqq/urbooks-server"
  spec.metadata["source_code_uri"] = "https://github.com/ohzqq/urbooks-server"
  spec.metadata["changelog_uri"] = "https://github.com/ohzqq/urbooks-server"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_dependency "rabl", "~> 0.15.0"
  spec.add_dependency "commander", "~> 4.6.0"
  spec.add_dependency "json", "~> 2.6.1"
  spec.add_dependency "sinatra", "~> 2.2.0"
  spec.add_dependency "pagy", "~> 5.10.1"
  spec.add_dependency "puma", "~> 5.6.2"
  spec.add_dependency "yaml", "~> 0.2.0"
  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
