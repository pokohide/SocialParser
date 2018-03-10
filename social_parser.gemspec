
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "social_parser/version"

Gem::Specification.new do |spec|
  spec.name          = "social_parser"
  spec.version       = SocialParser::VERSION
  spec.authors       = ["pokohide"]
  spec.email         = ["hyde14142@gmail.com"]

  spec.summary       = %q{Parse social media attributes from url or construct url from attributes}
  spec.description   = %q{Parse social media attributes from url or construct url from attributes}
  spec.homepage      = 'https://github.com/hyde2able/SocialParser'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'public_suffix'
end
