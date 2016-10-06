require 'sinatra'
require 'active_record'
require 'yaml'
require './models/message'

after do
  ActiveRecord::Base.connection.close
end

dbconfig = YAML.load(ERB.new(File.read("config/database.yml")).result)

# YOU MUST SET THE ENV RACK_ENV to 'production' FOR YOUR CATRIDGE
RACK_ENV ||= ENV["RACK_ENV"] || 'development'
ActiveRecord::Base.establish_connection dbconfig[RACK_ENV]

get '/' do
  @messages = Message.all
  haml(:index, cache: false)
end

get '/message' do
  haml(:new_message, cache: false)
end

post '/message' do
  @message = Message.new(params[:message])

  if @message.save
    redirect '/'
  else
    'Buuuuu'
  end
end
