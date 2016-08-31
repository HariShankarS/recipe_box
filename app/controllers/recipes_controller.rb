class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def index
  	@recipes = Recipe.all.order("created_at DESC")
  end

  def show
  end

  def create
  	@recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      redirect_to @recipe, notice: "Successfully created New Recipe"
    else
      render 'new'
    end

  end

  def edit    
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: "Deleted Successfully"
  end

  def new
  	@recipe = Recipe.new
  end

  private

  def recipe_params  
    params.require(:recipe).permit(:title, :description, :user_id, :image, ingredients_attributes: [:id, :name,:_destroy], directions_attributes: [:id, :step, :_destroy]) 
  end
  
  def find_recipe
  	@recipe = Recipe.find(params[:id])
  end

end
