# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_chimpy'
  s.version     = '2.0.0.alpha'
  s.summary     = 'MailChimp/Solidus integration using the mailchimp gem'
  s.description = s.summary
  s.required_ruby_version = '>= 2.5.0'

  s.author    = 'Joshua Nussbaum'
  s.email     = 'josh@godynamo.com'
  s.homepage  = 'http://www.godynamo.com'
  s.license   = %q{BSD-3}

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'solidus', '~>2.4'
  s.add_dependency 'gibbon', '~> 3.2'

  s.add_development_dependency 'rspec-rails', '~> 3.7'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'capybara', '~> 2.17'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'factory_bot_rails', '~> 4.8'
  s.add_development_dependency 'shoulda-matchers', '~> 2.5'
  s.add_development_dependency 'sqlite3', '~> 1.3.9'
  s.add_development_dependency 'simplecov', '0.7.1'
  s.add_development_dependency 'database_cleaner', '1.6.2'
  s.add_development_dependency 'coffee-rails', '~> 4.2.2'
  s.add_development_dependency 'sass-rails', '~> 5.0.7'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'launchy'
end
