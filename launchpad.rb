require "sinatra"
require "thin"
require "chartkick"
require_relative "database_persistence"
require_relative "simple_calendar"
# test github again
configure do
  set :server, "thin"
end

configure(:development) do
  require "sinatra/reloader" if development?
  also_reload "database_persistence.rb"
  also_reload "simple_calendar.rb"
end

before do
  @storage = DatabasePersistence.new(logger)
end

after do
  @storage.disconnect
end

helpers do
  include CalendarHelper

  def previous_page
    new_page = @current_page.to_i - 1 
    new_page < 0 ? 0 : new_page
  end
  
  def next_page
    @current_page.to_i + 1
  end
  
  def paginate
    if @current_page <= 3
      [1, 2, 3, 4, 5]
    elsif @current_page + 5 >= @page_count
      [@page_count - 4, @page_count - 3, @page_count - 2,  @page_count - 1, @page_count]
    else
      [@current_page - 2, @current_page - 1, @current_page, @current_page + 1, @current_page + 2]
    end
  end
  
  def extract_minutes_hours(duration)
    duration.split(":").map(&:to_i)
  end
end

get "/" do
  
  erb :home
end

get "/log" do
  @parameters = params
  @page_count = (@storage.entries_count.to_f / DatabasePersistence::TIMELOG_DISPLAY_COUNT).ceil
  
  if params["page"].to_i < 1
    @current_page = 1
  else
    @current_page = params["page"].to_i
  end
  
  @log = @storage.timelog(@current_page)
  
  erb :log
end

post "/log" do
  date = params[:date]
  course = params[:course]
  lesson = params[:lesson]
  hours = params[:hours]
  minutes = params[:minutes]
  notes = params[:notes]
  
  @storage.add_entry(date, course, lesson, hours, minutes, notes)
  redirect "/log"
end

post "/log/edit" do
  log_id = params[:log_id]
  date = params[:date]
  course = params[:course]
  lesson = params[:lesson]
  duration = params[:duration]
  notes = params[:notes]
  
  hours, minutes = extract_minutes_hours(duration)
  
  @storage.edit_entry(log_id, date, course, lesson, hours, minutes, notes)
  redirect "/log"
end

post "/log/sort" do
  # go back to the first page of a new sort
  # update the order by clause with arguments if it exists from this post method
  # default arguments are date desc, time desc
  # post is true false alternating for asc or desc
end

get "/progress" do
  @courses = @storage.all_courses
  erb :progress
end

get "/calendar" do
  @year = 2005
  @month = 6
  erb :calendar
end

get "/reports" do
  @title = "Study hours per day"
  # @data = {'2015-07-20 00:00:00 UTC' => 2, '2015-07-21 00:00:00 UTC' => 4, '2015-07-22 00:00:00 UTC' => 1, '2015-07-23 00:00:00 UTC' => 7}
  @data = @storage.study_hours_per_day
  @data_2 = @storage.study_hours_per_course
  @data2 = [{name: "Series A", data: [["0",32],["1",46],["2",28],["3",21],["4",20],["5",13],["6",27]]}, {name: "Series B", data: [["0",32],["1",46],["2",28],["3",21],["4",20],["5",13],["6",27]]}]
  erb :reports
end

get "/about" do
  erb :about
end

get "/account" do
  erb :account
end