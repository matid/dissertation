require "active_record"
require "logger"
require "erb"

ActiveRecord::Base.logger = Logger.new((Dissertation.root +  "common" + "log" + "development.log").to_s)
ActiveRecord::Base.establish_connection(YAML::load(ERB.new(IO.read(File.open(Dissertation.root + "common" + "config" + "database.yml"))).result))