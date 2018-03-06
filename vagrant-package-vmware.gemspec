
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vagrant-ssh-config-cache/version"

Gem::Specification.new do |spec|
  spec.name          = "vagrant-ssh-config-cache"
  spec.version       = VagrantPlugins::SSHConfigCache::VERSION
  spec.authors       = ["David Kramer"]
  spec.email         = ["bacongravy@icloud.com"]

  spec.summary       = %q{Enables Vagrant to cache the ssh-config of running boxes}
  spec.homepage      = "https://github.com/bacongravy/vagrant-ssh-config-cache"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
