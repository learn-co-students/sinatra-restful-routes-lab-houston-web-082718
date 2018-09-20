class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::MethodOverride
  end

  get '/' do
    erb :index
  end

# displays all the recipes
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

# displays new recipe form
  get '/recipes/new' do
    erb :new
  end

# create a new recipe
  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end


# shows an individual recipe
    get '/recipes/:id' do
      @recipe = Recipe.find_by_id(params[:id])
      erb :show
      # binding.pry
    end

# deletes a recipe
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect "/recipes"
  end

# displays edit recipe form
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

# updates recipe with new info
  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

end
