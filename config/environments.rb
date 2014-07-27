#These Settings Establish the Proper Database Connection for Heroku Postgres
#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path
#This is automatically configured on Heroku, you only need to worry if you also
#want to run your app locally
dbconfig = YAML.load(ERB.new(File.read(File.join("config","database.yml"))).result)
RACK_ENV ||= ENV["RACK_ENV"] || "development"
ActiveRecord::Base.establish_connection dbconfig[RACK_ENV]
