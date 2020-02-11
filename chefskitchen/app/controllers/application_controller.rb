require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "cookingisfun"
    use Rack::Flash
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def current_user
      @current_user = Chef.find_by(id: session[:user_id])
    end

    def logged_in?
      !!current_user
    end
  end

end