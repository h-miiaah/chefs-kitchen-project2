class RecipesController < ApplicationController
    
    get '/recipes' do
        if logged_in?
            @recipes = Recipes.all
            erb :'recipes/recipes'
        else
            redirect '/login'
        end
    end
end