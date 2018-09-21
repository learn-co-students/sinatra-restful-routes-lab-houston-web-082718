class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # displays all the recipes in the database
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # will render a form to create a new recipe
  # should create and save this new recipe to the database
  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    redirect "/recipes/#{recipe.id}"
  end

  # use RESTful routes to display a single recipe
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  # use RESTful routes and renders a form to edit a single recipe
  # should update the entry in the database with the changes, 
  # and then redirect to the recipe show page
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    redirect "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do
    Recipe.find(params[:id]).destroy
    
    redirect '/recipes'
  end
end