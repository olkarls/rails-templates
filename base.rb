run "rm 'public/index.html'"
run "rm 'public/javascripts/controls.js'"
run "rm 'public/javascripts/dragdrop.js'"
run "rm 'public/javascripts/effects.js'"
run "rm 'public/javascripts/prototype.js'"

run "echo TODO:Write documentation > README"

gem 'haml'
gem 'searchlogic'
gem 'justinfrench-formtastic', :lib => 'formtastic', :source => 'http://gems.github.com'
gem 'mislav-will_paginate', :version => '~> 2.3.11', :lib => 'will_paginate', :source => 'http://gems.github.com'

plugin "validation_reflection", :git => "git://github.com/redinger/validation_reflection.git"
plugin "custom-err-msg", :git => "git://github.com/gumayunov/custom-err-msg.git"

git :init

file ".gitignore", <<-END
  .DS_Store
  log/*.log
  tmp/**/*
  config.database.yml
  db/*.sqlite3
END

run "touch tmp/.gitignore log.gitignore vendor/.gitignore"
run "cp config/database.yml config/ example_database.yml"

git :add => ".", :commit => "-m 'Initial commit'" 