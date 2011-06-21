# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "widget/version"

Gem::Specification.new do |s|
  s.name        = "widget"
  s.version     = Widget::VERSION::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mike Bethany"]
  s.email       = ["mikbe.tk@gmail.com"]
  s.homepage    = "http://mikbe.tk"
  s.summary     = %q{A demonstration app showing how to use Commandable and HashModel.}
  s.description = %q{A demonstration app showing how to use Commandable and HashModel. It also serves as a test platform for fleshing out problems and designing new features for the aforementioned libraries.}
  
  s.add_dependency("hashmodel", "~>0.4")
  s.add_dependency("commandable", "~>0.2.1")

  s.add_dependency("rspec", "~>2.5")
  s.add_dependency("aruba", "~>0.3")
  s.add_dependency("cucumber", "~>0.10")
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
