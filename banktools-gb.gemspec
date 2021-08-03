# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "banktools-gb/version"

Gem::Specification.new do |spec|
  spec.name          = "banktools-gb"
  spec.version       = BankTools::GB::VERSION
  spec.authors       = [ "Tomas Skogberg" ]
  spec.email         = [ "tomas@auctionet.com" ]

  spec.summary       = %q{Validate and normalise United Kingdom bank account numbers.}
  spec.homepage      = "https://github.com/barsoom/banktools-gb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = [ "lib" ]

  spec.add_dependency "attr_extras"

  spec.add_development_dependency "bundler", ">= 1"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3"
end
