css_framework = ask("What CSS Framework do you want to use with Compass? (default: '960')")
css_framework = "960" if css_framework.blank?

sass_dir = ask("Where would you like to keep your sass files within your project? (default: 'app/sass')")
sass_dir = "app/sass" if sass_dir.blank?

css_dir = ask("Where would you like Compass to store your compiled css files? (default: 'public/stylesheets/')")
css_dir = "public/stylesheets/" if css_dir.blank?

gem "haml", :lib => "haml", :version => ">=2.2.0"
gem "chriseppstein-compass", :source => "http://gems.github.com/", :lib => "compass"

rake "gems:install GEM=haml", :sudo => true
rake "gems:install GEM=chriseppstein-compass", :sudo => true

if css_framework =~ /960/
  gem "chriseppstein-compass-960-plugin", :source => "http://gems.github.com", :lib => "ninesixty"
  rake "gems:install GEM=chriseppstein-compass-960-plugin", :sudo => true
  css_framework = "960"
  plugin_require = "-r ninesixty"
end

compass_command = "compass --rails -f #{css_framework} . --css-dir=#{css_dir} --sass-dir=#{sass_dir} "
compass_command << plugin_require if plugin_require

file 'vendor/plugins/compass/init.rb', <<-CODE
# This is here to make sure that the right version of sass gets loaded (haml 2.2) by the compass requires.
require 'compass'
CODE

run "haml --rails ."
run compass_command

run "rm 'public/index.html'"
run "rm 'public/javascripts/controls.js'"
run "rm 'public/javascripts/dragdrop.js'"
run "rm 'public/javascripts/effects.js'"
run "rm 'public/javascripts/prototype.js'"

run "echo TODO: Write documentation > README"

gem 'haml'
gem 'searchlogic'
gem 'mislav-will_paginate', :version => '~> 2.3.11', :lib => 'will_paginate', :source => 'http://gems.github.com'
gem 'justinfrench-formtastic', :lib => 'formtastic', :source => 'http://gems.github.com'
gem 'redinger-validation_reflection'
gem 'validatious-on-rails', :source => 'http://gemcutter.org'

rake "gems:install", :sudo => true

plugin "custom-err-msg", :git => "git://github.com/gumayunov/custom-err-msg.git"

generate :formtastic
generate :validatious

git :init

file ".gitignore", <<-END
.DS_Store
log/*.log
tmp/**/*
config.database.yml
db/*.sqlite3
END

run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/ example_database.yml"

git :add => ".", :commit => "-m 'Initial commit'" 