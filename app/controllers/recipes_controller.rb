class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.order(date: :desc)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new
    uploader = ImageUploader.new

    if uploader.store!(params[:recipe][:image])
      @recipe.image = uploader.file.filename
      if @recipe.save
        @recipe.analyze_image_and_store_recipes
        redirect_to recipe_path(@recipe.id), notice: "Recipes successfully generated and stored."
      else
        render :new
      end
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:image)
  end
end
