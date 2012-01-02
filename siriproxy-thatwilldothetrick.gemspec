# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "siriproxy-thatwilldothetrick"
  s.version     = "0.0.1" 
  s.authors     = ["stephaneag"]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = %q{A "That will do the trick!" plugin.}
  s.description = %q{Simple test plugin from the well know That's what she said plugin. }

  s.rubyforge_project = "thatwilldothetrick"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
   s.add_runtime_dependency "url_escape"
end
