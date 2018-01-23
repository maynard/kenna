
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kenna/version"

Gem::Specification.new do |spec|
  spec.name          = "kenna"
  spec.version       = Kenna::VERSION
  spec.authors       = ["maynard"]
  spec.email         = ["maynardblack@hotmail.com"]

  spec.summary       = %q{Kenna API Client}
  spec.description   = %q{Kenna is an API client that wraps the Kenna Security API (https://api.kennasecurity.com).}
  spec.homepage      = "https://github.com/maynard/kenna.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "test-unit", "~> 3.2"
end
