

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    erb :index
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
  erb :new
  # redirect '/recipes'
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])

    erb :show
  end

  post '/recipes' do
    @recipes = Recipe.create(params[:recipe])
    redirect '/recipes'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])

    @recipe.update(params[:recipe])
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])

    @recipe.destroy 

    redirect '/recipes'
  end
end