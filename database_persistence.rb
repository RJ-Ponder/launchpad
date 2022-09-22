require "pg"
require "date"

class DatabasePersistence
  TIMELOG_DISPLAY_COUNT = 15
  
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
  
  def timelog(current_page)
    offset = (current_page.to_i - 1) * TIMELOG_DISPLAY_COUNT
    sql = <<~SQL
      SELECT id, TO_CHAR(date, 'MM/DD/YYYY') AS date, time, course, lesson,  hours, minutes, CONCAT(hours, ':', TO_CHAR(minutes, 'fm00')) AS "duration", notes
      FROM timelog AS t
      ORDER BY t.date DESC, time DESC
      LIMIT $1
      OFFSET $2;
    SQL
    
    result = query(sql, TIMELOG_DISPLAY_COUNT, offset)
    result.map do |tuple|
      { id: tuple["id"], date: tuple["date"], time: tuple["time"], course: tuple["course"], lesson: tuple["lesson"], hours: tuple["hours"], minutes: tuple["minutes"], duration: tuple["duration"], notes: tuple["notes"] }
    end
  end
  
  def entries_count
    sql = "SELECT COUNT(id) FROM timelog;"
    result = query(sql)
    result.values.flatten[0]
  end
  
  def add_entry(date, course, lesson, hours, minutes, notes)
    sql = "INSERT INTO timelog (date, course, lesson, hours, minutes, notes) VALUES ($1, $2, $3, $4, $5, $6);"
    query(sql, date, course, lesson, hours, minutes, notes)
  end
  
  def study_hours_per_day
    # week - either past 7 days or Monday - Sunday or Sunday - Saturday
    # month - either past 30 days or calendar month
    # custom - start date and end date
    start_date = (Date.today - 7)
    end_date = (Date.today - 1)
    
    # Write a method that creates a hash of dates in a range with a key of the date and a value of 0
    
    
    sql = <<~SQL
      SELECT TO_CHAR(date, 'Dy, MM/DD') AS date, ROUND(SUM(hours) + SUM(minutes)/60.0, 2) AS hours
      FROM timelog as t
      WHERE t.date >= $1 AND t.date <= $2
      GROUP BY t.date
      ORDER BY t.date;
    SQL
    result = query(sql, start_date, end_date)
    date_range = create_date_hash(start_date, end_date)
    result.each do |tuple|
      date_range[tuple["date"]] = tuple["hours"]
    end
    date_range
  end
  
  def study_hours_per_course
    sql = <<~SQL
      SELECT course, ROUND(SUM(hours) + SUM(minutes)/60.0, 2) AS hours
      FROM timelog
      JOIN courses ON course_number = course
      GROUP BY course, courses.id
      ORDER BY courses.id;
    SQL
    
    result = query(sql)
    course_hours = {}
    result.each do |tuple|
      course_hours[tuple["course"]] = tuple["hours"]
    end
    course_hours
  end
  
  def edit_entry(log_id, date, course, lesson, hours, minutes, notes)
    sql = <<~SQL
      UPDATE timelog
      SET date = $1, course = $2, lesson = $3, hours = $4, minutes = $5, notes = $6
      WHERE id = $7;
    SQL
    query(sql, date, course, lesson, hours, minutes, notes, log_id)
  end
  
  def disconnect
    @db.close
  end
  
  private
  
  def create_date_hash(start_date, end_date)
    hash = {}
    loop do
      formatted_date = start_date.strftime('%a, %m/%d')
      hash[formatted_date] = 0
      start_date += 1
      break if start_date > end_date
    end
    hash
  end
end
