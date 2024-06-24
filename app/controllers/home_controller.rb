class HomeController < ApplicationController
  def index
    @recipe = Recipe.new
  end

  def about
  end
end
