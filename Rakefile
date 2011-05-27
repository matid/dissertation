require_relative "init"

namespace :db do
  desc "Migrate the database through scripts in db/migrate."
  task :migrate do
    ActiveRecord::Migrator.migrate(Dissertation.root + "common" + "db" + "migrate")
  end

  task :rollback do
    ActiveRecord::Migrator.rollback(Dissertation.root + "common" + "db" + "migrate")
  end
end
