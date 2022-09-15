require "sinatra"
require "thin"
require "chartkick"
require_relative "database_persistence"
require_relative "simple_calendar"

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
    new_page = @page.to_i - 1 
    new_page < 0 ? 0 : new_page
  end
  
  def next_page
    @page.to_i + 1
  end
end

get "/" do
  
  erb :home
end

get "/log" do
  if params["page"].to_i < 0
    @page = 0
  else
    @page = params["page"].to_i
  end
  @log = @storage.timelog(@page)
  erb :log
end

post "/log" do
  date = params[:date]
  course = params[:course]
  lesson = params[:lesson]
  hours = params[:hours]
  minutes = params[:minutes]
  notes = params[:notes]
  time = minutes.to_i / 60 + hours.to_i
  
  @storage.add_entry(date, course, lesson, time, notes)
  redirect "/log"
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
  @data = @storage.hours_per_day_last_ten
  erb :reports
end

get "/about" do
  erb :about
end

get "/account" do
  erb :account
end