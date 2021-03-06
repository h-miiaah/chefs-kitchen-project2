class ChefsController < ApplicationController
    
    get '/signup' do
        if !logged_in?
            erb :'chefs/create_chef'
            # flash[:error] = "Please sign up if you do not have an account."
        else
            redirect "/recipes"
        end
    end

    post '/signup' do
        if (params[:username]).empty? || (params[:email]).empty? || (params[:password]).empty?
            flash[:error] = "Username, Email, or Password is not filled in."
            redirect '/signup'
        else
            @chef = Chef.create(username: params[:username], email: params[:email], password_digest: params[:password_digest])
            session[:user_id] = @chef.id
            redirect "/recipes"
        end
    end

    get '/login' do
        if !logged_in?
            erb :'chefs/login'
        else
            redirect "/recipes"
        end
    end

    post '/login' do
        chef = Chef.find_by(:username => params[:username])
        if chef && chef.authenticate(params[:password])
            session[:user_id] = chef.id
            redirect "/recipes"
        elsif
            (params[:username]).empty? || (params[:password]).empty?
            flash[:error] = "Username or Password is not filled in."
            redirect "/login"
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect '/'
        end
    end

end