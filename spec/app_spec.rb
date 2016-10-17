require 'spec_helper'

describe 'message aplication' do
  it 'should display new message form' do
    get '/message'

    expect(last_response.body).to include('Add new message')
  end

  it 'should display all fields' do
    get '/message'

    expect(last_response.body).to include('msg-text',
                                          'destroy_option',
                                          'message[countdown]',
                                          'pass',
                                          'message[body]',
                                          'message[password]'
                                  )
  end

  it 'should display home page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'should validates body, destroy_option, countdown, password' do
    msg = Message.new
    expect(msg).to_not be_valid
    valid_msg = Message.new(FactoryGirl.attributes_for(:message))
    expect(valid_msg).to be_valid
  end

  it 'should ask password before the view' do
    msg = FactoryGirl.create(:message)

    get "/message/#{msg.url_alias}"
    expect(last_response.body).to include('Password')
  end
end
