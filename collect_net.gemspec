# -*- encoding: utf-8 -*-
require File.expand_path('../lib/collect_net/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["jiangyuezhang@yahoo.com.cn"]
  gem.email         = ["jiangyuezhang@yahoo.com.cn"]
  gem.description   = %q{this is a gem that can help you collect some thing from the internet}
  gem.summary       = %q{what a summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "collect_net"
  gem.require_paths = ["lib"]
  gem.version       = CollectNet::VERSION
  gem.add_dependency "nokogiri"
  gem.add_dependency "mechanize"
end
