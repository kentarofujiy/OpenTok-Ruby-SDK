require 'sinatra/base'
require 'opentok'

raise "You must define API_KEY and API_SECRET environment variables" unless ENV.has_key?("API_KEY") && ENV.has_key?("API_SECRET")

class HelloWorld < Sinatra::Base

  set :api_key, ENV['API_KEY']
  set :opentok, OpenTok::OpenTok.new(api_key, ENV['API_SECRET'])
  set :session, opentok.create_session

  set :kapi_key, ENV['API_KEY']
  set :kopentok, OpenTok::OpenTok.new(kapi_key, ENV['API_SECRET'])
  set :ksession, kopentok.create_session

  get '/' do

    api_key = settings.api_key
    session_id = settings.session.session_id
    #session_id = OpenTok::OpenTok.new(api_key, ENV['API_SECRET']).create_session
    token = settings.opentok.generate_token(session_id)

    erb :index, :locals => {
      :api_key => api_key,
      :session_id => session_id,
      :token => token
    }
  end
 get '/kentaro' do

    kapi_key = settings.kapi_key
    ksession_id = settings.ksession.session_id
    #session_id = OpenTok::OpenTok.new(api_key, ENV['API_SECRET']).create_session
    ktoken = settings.kopentok.generate_token(ksession_id)

    erb :index, :locals => {
      :api_key => kapi_key,
      :session_id => ksession_id,
      :token => ktoken
    }
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
