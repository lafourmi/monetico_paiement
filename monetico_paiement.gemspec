# frozen_string_literal: true

require_relative "lib/monetico_paiement/version"

Gem::Specification.new do |spec|
  spec.name          = "monetico_paiement"
  spec.version       = MoneticoPaiement::VERSION
  spec.authors       = ["Guillaume Dott"]
  spec.email         = ["guillaume+github@dott.fr"]

  spec.summary       = "Monetico Paiement credit card payment toolbox"
  spec.description   = "Monetico Paiement is a gem to ease credit card payment with the Monetico Paiement bank system."
  spec.homepage      = "https://code.amnesix.eu/guillaume/monetico_paiement"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "openssl", "~> 2.2"
  spec.add_dependency "json"

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "irb"
  spec.add_development_dependency "minitest"
end
