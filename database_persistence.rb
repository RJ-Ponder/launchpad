require "pg"

class DatabasePersistence
  def initialize(logger)
    @db = PG.connect(dbname: "launchpad")
    @logger = logger
  end
  
  def query(statement, *params)
    @logger.info "#{statement}: #{params}"
    @db.exec_params(statement, params)
  end
end