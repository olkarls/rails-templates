run "rm 'public/index.html'"
run "rm 'public/javascripts/controls.js'"
run "rm 'public/javascripts/dragdrop.js'"
run "rm 'public/javascripts/effects.js'"
run "rm 'public/javascripts/prototype.js'"

run "echo TODO:Write documentation > README"

gem 'haml'
gem 'searchlogic'
gem 'mislav-will_paginate', :version => '~> 2.3.11', :lib => 'will_paginate', :source => 'http://gems.github.com'
gem 'justinfrench-formtastic', :lib => 'formtastic', :source => 'http://gems.github.com'
gem 'validatious-on-rails', :source => 'http://gemcutter.org'
gem 'chriseppstein-compass', :source => 'http://gems.github.com'

rake "gems:install", :sudo => true

plugin "validation_reflection", :git => "git://github.com/redinger/validation_reflection.git"
plugin "custom-err-msg", :git => "git://github.com/gumayunov/custom-err-msg.git"
plugin "chriseppstein-compass-960-plugin", :git => "git://github.com/chriseppstein/compass.git"

generate :formtastic
generate :validatious

run "compass -r ninesixty -f 960 ."

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