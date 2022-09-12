require "sinatra"
require "sinatra/reloader"
require "thin"
require_relative "database_persistence"

configure do
  set :server, "thin"
end

get "/" do
  erb :home
end

get "/log" do
  erb :log
end

get "/progress" do
  erb :progress
end

get "/calendar" do
  erb :calendar
end

get "/reports" do
  erb :reports
end

get "/about" do
  erb :about
end

get "/account" do
  erb :account
end