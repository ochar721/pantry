class CookBook
  attr_reader :recipes

  def initialize
    @recipes =[]
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def ingredients #refactor this shit
    @recipes.flat_map do |recipe|
      recipe.ingredients.flat_map do |ingredient|
        ingredient.name
      end
    end.uniq
  end

  def highest_calorie_meal
    @recipes.max_by do |recipe|
      recipe.total_calories
    end
  end
end
