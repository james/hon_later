require './app'
require 'sinatra/activerecord/rake'

task :update do
  TinyletterScraper.instance.save_new_links
  Link.print_unprinted!
end