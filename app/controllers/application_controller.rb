require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/' do
    erb :default
  end

  get '/recipes/new' do
    @ingredients = Recipe.all.first.ingredients
    erb :new
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  post '/recipes' do
    @recipe = Recipe.new
    @recipe.name        = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time   = params[:cook_time]
    @recipe.save

    redirect "/recipes/#{Recipe.last.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe             = Recipe.find(params[:id])
    @recipe.name        = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time   = params[:cook_time]
    @recipe.save

    erb :show
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    erb :delete
  end

  # get '/recipes/:id/delete' do
  #   # @recipe = Recipe.find(params[:id])
  #   erb :delete
  # end

end