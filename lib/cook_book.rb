class CookBook
  attr_reader :recipes, :date

  def initialize
    @recipes = []
    @date = Date.today.strftime("%m-%d-%Y")
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def ingredients
    @recipes.flat_map do |recipe|
      recipe.ingredients.flat_map do |ingredient, _|
        ingredient.name
      end
    end.uniq
  end

  def highest_calorie_meal
    @recipes.max_by do |recipe|
      recipe.total_calories
    end
  end

  def summary
    summary = []
    @recipes.each do |recipe|
      recipe_summary = {
        name: recipe.name,
        details: {
          ingredients: [],
          total_calories: recipe.total_calories
        }
      }
      sorted_ingredients = recipe.ingredients.sort_by do |ingredient|
        ingredient.calories * recipe.amount_required(ingredient)
      end.reverse
      sorted_ingredients.each do |ingredient|
        amount = "#{recipe.amount_required(ingredient)} #{ingredient.unit}"
        ingredient_hash = {ingredient: ingredient.name, amount: amount}
        recipe_summary[:details][:ingredients] << ingredient_hash
      end
      summary << recipe_summary
    end
    summary
  end
end
