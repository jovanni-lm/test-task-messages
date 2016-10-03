require 'sinatra'
require 'active_record'

YAML::load(File.open('config/database.yml'))[env].symbolize_keys.each do |key, value|
  set key, value
end

get '/' do
  haml(:index, cache: false)
end

get '/new_message' do
  haml(:new_message, cache: false)
end

post '/new_message' do

end
