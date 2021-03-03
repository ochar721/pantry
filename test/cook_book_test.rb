require 'minitest/autorun'
require 'minitest/pride'
require 'date'
require 'mocha/minitest'
require './lib/cook_book'
require './lib/ingredient'
require './lib/recipe'

class CookBookTest < Minitest::Test
  def setup
    @cookbook = CookBook.new
    @cheese = Ingredient.new(name: "Cheese", unit: "C", calories: 100)
    @mac = Ingredient.new(name: "Macaroni", unit: "oz", calories: 30)
    @mac_and_cheese = Recipe.new("Mac and Cheese")
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)

    @ground_beef = Ingredient.new(name: "Ground Beef", unit: "oz", calories: 100)
    @bun = Ingredient.new(name: "Bun", unit: "g", calories: 1)
    @burger = Recipe.new("Burger")
    @burger.add_ingredient(@ground_beef, 4)
    @burger.add_ingredient(@bun, 100)
  end

  def test_it_exists
    assert_instance_of CookBook, @cookbook
  end

  def test_it_has_a_date
    book = CookBook.new

    assert_instance_of String, book.date
    
    book.stubs(:date).returns("06-07-2020")

    assert_equal "06-07-2020", book.date
  end

  def test_it_starts_with_no_recipes
    assert_equal [], @cookbook.recipes
  end

  def test_it_can_add_recipes
    @cookbook.add_recipe(@mac_and_cheese)
    @cookbook.add_recipe(@burger)

    assert_equal [@mac_and_cheese, @burger], @cookbook.recipes
  end

  def test_it_can_create_a_summary_of_all_recipes
    @cookbook.add_recipe(@mac_and_cheese)
    @cookbook.add_recipe(@burger)

    expected = [
      {
        name: "Mac and Cheese",
        details: {
          ingredients: [
            {ingredient: "Macaroni", amount: "8 oz"},
            {ingredient: "Cheese", amount: "2 C"}
          ],
          total_calories: 440
        }
      },
      {
      name: "Burger",
      details: {
        ingredients: [
          {ingredient: "Ground Beef", amount: "4 oz"},
          {ingredient: "Bun", amount: "100 g"}
        ],
        total_calories: 500
        }
      }
    ]

    assert_equal expected, @cookbook.summary
  end
end
