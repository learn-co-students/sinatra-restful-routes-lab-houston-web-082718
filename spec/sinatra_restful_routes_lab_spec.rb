require 'spec_helper'

describe "Recipe App" do
  let(:recipe_name) { "Bomb.com Mac and Cheese" }
  let(:recipe_ingredients) { "milk, butter, cheese, elbow pasta" }
  let(:recipe_cook_time) { "20 minutes" }

  before do
    @recipe1 = Recipe.create(:name => recipe_name, :ingredients => recipe_ingredients, :cook_time => recipe_cook_time)
    @recipe2 = Recipe.create(:name => "waldorf salad", :ingredients => "apples, cabbage, oil, vinegar", :cook_time => "0")
  end

  describe "Index page '/recipes'" do
    before do
      get "/recipes"
    end

    it 'responds with a 200 status code' do
      expect(last_response.status).to eq(200)
    end

    it "displays a list of recipes" do
      expect(last_response.body).to include(recipe_name)
      expect(last_response.body).to include(@recipe2.name)

    end

    it "contains links to each recipe's show page" do
      expect(last_response.body).to include("/recipes/#{@recipe1.id}")
    end
  end

    
  describe "show page '/recipes/:id'" do
    before do
      get "/recipes/#{@recipe1.id}"
    end

    it 'responds with a 200 status code' do
      expect(last_response.status).to eq(200)
    end

    it "displays the recipe's name" do
      expect(last_response.body).to include(recipe_name)

    end

    it "displays the recipe's ingredients" do
      expect(last_response.body).to include(recipe_ingredients)
    end
  end

  describe "edit page '/recipes/:id/edit'" do
    before do
      get "/recipes/#{@recipe1.id}/edit"
    end

    it 'responds with a 200 status code' do
      expect(last_response.status).to eq(200)
    end

    it "contains a form to edit the recipe" do
      expect(last_response.body).to include("</form>")

    end

    it "displays the recipe's ingredients before editing" do
      expect(last_response.body).to include(recipe_ingredients)
    end

    

  end

  describe "new page '/recipes/new'" do
    before do
      get "/recipes/new"
    end

    it 'responds with a 200 status code' do
      expect(last_response.status).to eq(200)
    end

    it "contains a form to create the recipe" do
      expect(last_response.body).to include("</form>")
    end
  end
end
