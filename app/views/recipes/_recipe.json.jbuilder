json.extract! recipe, :id, :image, :recipe_titles, :date, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
