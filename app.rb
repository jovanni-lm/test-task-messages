require 'rubygems'
require 'sinatra'
require 'active_record'
require 'yaml'
require './models/message'
require 'sinatra/flash'

enable :sessions

after '/message/:id' do
  destroy_message_for_visits
end

after do
  ActiveRecord::Base.connection.close
end

dbconfig = YAML.load(ERB.new(File.read('config/database.yml')).result)

# YOU MUST SET THE ENV RACK_ENV to 'production' FOR YOUR CATRIDGE
RACK_ENV ||= ENV['RACK_ENV'] || 'development'
ActiveRecord::Base.establish_connection dbconfig[RACK_ENV]

get '/' do
  @messages = Message.all
  haml(:index, cache: false)
end

get '/message' do
  haml(:new_message, cache: false)
end

get '/message/:id' do
  load_message

  if @message.id.present?
    haml(:password, cache: false)
  else
    flash[:danger] = 'Message is not exists.'
    redirect '/'
  end
end

post '/message/:id' do
  load_message

  @input_pass = Digest::MD5.new
  @input_pass << params[:pass]

  if @input_pass.to_s[0...16] == @message.password
    if @message.destroy_option == 'visits'
      @message.countdown -= 1
      @message.save
    end
    haml(:show_message)
  else
    flash[:danger] = 'Wrong password.'
    redirect "message/#{@message.url_alias}"
  end
end

post '/new-message' do
  @message = Message.new(params[:message])

  if @message.save
    # hotfix
    flash[:info] = "Message was successfully created,
 <a href='message/#{@message.url_alias}'>see here</a>."
    redirect '/'
  else
    flash[:danger] = @message.errors.full_messages.to_sentence
    redirect '/message'
  end
end

def load_message
  @message = Message.find_or_initialize_by(url_alias: params[:id])
end

def destroy_message_for_visits
  load_message

  if @message.id.present? && @message.destroy_option == 'visits' &&
      @message.countdown <= 0
    @message.destroy
  end
end
