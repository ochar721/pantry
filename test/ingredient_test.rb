require 'minitest/autorun'
require 'minitest/pride'
require './lib/ingredient'

class IngredientTest < Minitest::Test
  def test_it_exists_and_has_attributes
  ingredient1 = Ingredient.new({name: "Cheese", unit: "oz", calories: 50})
  ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 200})

  assert_instance_of Ingredient, ingredient1

  assert_equal "Cheese", ingredient1.name
  assert_equal "oz", ingredient1.unit
  assert_equal 50, ingredient1.calories

  assert_equal "Macaroni", ingredient2.name
  assert_equal "oz", ingredient2.unit
  assert_equal 200, ingredient2.calories
  end
end
