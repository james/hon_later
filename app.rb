require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/link'
require './lib/tinyletter_scraper'

dbconfig = YAML.load(File.read("config/database.yml"))
RACK_ENV ||= ENV["RACK_ENV"] || "development"
ActiveRecord::Base.establish_connection dbconfig[RACK_ENV]

get '/' do
  erb :index
end