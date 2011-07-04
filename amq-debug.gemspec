# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "amq-debug/version"

Gem::Specification.new do |s|
  s.name        = "amq-debug"
  s.version     = Amq::Debug::VERSION
  s.authors     = ["Caius Durling"]
  s.email       = ["caius@brightbox.co.uk"]
  s.homepage    = "http://www.brightbox.co.uk/"
  s.summary     = %q{Scripts which help me develop apps that use ActiveMQ}
  s.description = %q{Scripts which help me develop apps that use ActiveMQ}

  s.rubyforge_project = "amq-debug"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
