class ChefsController < ApplicationController
    
    get '/signup' do
        if !logged_in?
            erb :'chefs/create_chef', locals: {message: "Please sign up if you do not have an account."}
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

end