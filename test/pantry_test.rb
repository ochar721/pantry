require 'minitest/autorun'
require 'minitest/pride'
require './lib/pantry'
require './lib/ingredient'
require './lib/recipe'

class PantryTest < Minitest::Test
  def setup
    @pantry = Pantry.new
    @cheese = Ingredient.new(name: "Cheese", unit: "C", calories: 50)
    @mac = Ingredient.new(name: "Macaroni", unit: "oz", calories: 200)
    @mac_and_cheese = Recipe.new("Mac and Cheese")
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)
  end

  def test_it_exists
    assert_instance_of Pantry, @pantry
  end

  def test_it_starts_with_no_stock
    assert_equal ({}), @pantry.stock
  end

  def test_items_not_in_stock_default_to_zero
    assert_equal 0, @pantry.stock_check(@cheese)
  end

  def test_it_can_restock_ingredients
    @pantry.restock(@cheese, 5)
    @pantry.restock(@cheese, 10)
    assert_equal 15, @pantry.stock_check(@cheese)
  end

  def test_it_can_return_if_it_has_enough_ingredients_for_a_recipe
    @pantry.restock(@cheese, 2)
    assert_equal false, @pantry.enough_ingredients_for?(@mac_and_cheese)
    @pantry.restock(@mac, 8)
    assert_equal true, @pantry.enough_ingredients_for?(@mac_and_cheese)
  end
end
