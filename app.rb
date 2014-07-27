require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/link'
require './lib/tinyletter_scraper'

get '/' do
  erb :index
end