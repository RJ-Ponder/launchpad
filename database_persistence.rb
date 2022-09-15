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
  
  def all_courses
    sql = "SELECT * FROM courses;"
    result = query(sql)
    result.map do |tuple|
      { number: tuple["course_number"], name: tuple["name"], ruby: tuple["ruby"] == "t", javascript: tuple["javascript"] == "t" }
    end
  end
  
  def timelog(page)
    offset = page.to_i * 10
    sql ="SELECT * FROM timelog ORDER BY date DESC LIMIT 10 OFFSET $1;"
    result = query(sql, offset)
    result.map do |tuple|
      { day: tuple["date"], course_id: tuple["course"], lesson: tuple["lesson"], hours: tuple["hours"], notes: tuple["notes"] }
    end
  end
  
  def add_entry(date, course, lesson, time, notes)
    sql = "INSERT INTO timelog (date, course, lesson, hours, notes) VALUES ($1, $2, $3, $4, $5);"
    query(sql, date, course, lesson, time, notes)
  end
  
  def hours_per_day_last_ten
    sql = "SELECT day, sum(hours) FROM timelog GROUP BY day ORDER BY day DESC LIMIT 10;"
    result = query(sql)
    # I want 1 hash with each day as the key and each hour as the value
    day_hour_hash = {}
    result.map do |tuple|
      day_hour_hash[tuple["day"]] = tuple["sum"]
    end
    day_hour_hash
  end
  
  def disconnect
    @db.close
  end
end