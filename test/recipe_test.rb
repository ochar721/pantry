require 'minitest/autorun'
require 'minitest/pride'
require './lib/ingredient'
require './lib/recipe'

class RecipeTest < Minitest::Test
  def setup
    @cheese = Ingredient.new(name: "Cheese", unit: "C", calories: 100)
    @mac = Ingredient.new(name: "Macaroni", unit: "oz", calories: 30)
    @mac_and_cheese = Recipe.new("Mac and Cheese")
  end

  def test_it_exists
    assert_instance_of Recipe, @mac_and_cheese
  end

  def test_it_has_a_name
    assert_equal "Mac and Cheese", @mac_and_cheese.name
  end

  def test_it_starts_with_no_required_ingredients
    assert_equal ({}), @mac_and_cheese.ingredients_required
  end

  def test_it_can_add_ingredients
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)
    expected = {
      @cheese => 2,
      @mac => 8
    }
    assert_equal expected, @mac_and_cheese.ingredients_required
  end

  def test_it_can_return_amount_required
    @mac_and_cheese.add_ingredient(@cheese, 2)
    assert_equal 2, @mac_and_cheese.amount_required(@cheese)
  end

  def test_it_can_list_all_ingredients
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)

    assert_equal [@cheese, @mac], @mac_and_cheese.ingredients
  end

  def test_it_can_total_calories_of_ingredients
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)

    assert_equal 440, @mac_and_cheese.total_calories
  end
end
