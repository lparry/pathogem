# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pathogem/version"

Gem::Specification.new do |s|
  s.name        = "pathogem"
  s.version     = Pathogem::VERSION
  s.authors     = ["Lucas Parry"]
  s.email       = ["lucas@envato.com"]
  s.homepage    = "http://github.com/lparry/pathogem"
  s.summary     = %q{install vim plugins with ease.}
  s.description = %q{A manager for installing vim plugins cleanly into pathogen directories with ease.}

  s.rubyforge_project = "pathogem"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
