class Recipe
  attr_reader :name,
              :ingredients_required

  def initialize(name)
    @name                 = name
    @ingredients_required = Hash.new(0)
  end

  def add_ingredient(ingredient, amount)
    @ingredients_required[ingredient] += amount
  end

  def ingredients
    @ingredients_required.flat_map do |ingredient_required|
      ingredient_required[0]
   end
  end

  def total_calories
    @ingredients_required.sum do |ingredient, amount|
      ingredient.calories * amount
    end
  end
end
