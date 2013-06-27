# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bushido/version'

Gem::Specification.new do |spec|
  spec.name         = "bushido"
  spec.version      = Bushido::VERSION
  spec.author       = "akicho8"
  spec.email        = "akicho8@gmail.com"
  spec.homepage     = "https://github.com/akicho8/bushido"
  spec.summary      = "Shogi library"
  spec.description  = "Shogi library"
  spec.platform     = Gem::Platform::RUBY

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.rdoc_options  = ["--line-numbers", "--inline-source", "--charset=UTF-8", "--diagram", "--image-format=jpg"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  # for yard
  spec.add_development_dependency "yard"
  spec.add_development_dependency "redcarpet"
  spec.add_development_dependency "yard-rspec"
  spec.add_development_dependency "yard-rubicle"

  spec.add_dependency "activesupport", ">= 4.0.0"
  spec.add_dependency "rain_table" # git: "https://github.com/akicho8/rain_table.git" ← なんでダメ？
  spec.add_dependency "tapp"
  spec.add_dependency "pry"
  #pec s.add_dependency "pry-debugger"
end
