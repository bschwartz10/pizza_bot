require 'minitest/autorun'
require './lib/pizza_bot'

class PizzaBotTest < Minitest::Test
  def test_it_exists
    pizza_bot = PizzaBot.new("5x5 (1, 3)")

    assert_instance_of PizzaBot, pizza_bot
  end

  def test_initialized_with_drop_points
    pizza_bot = PizzaBot.new("5x5 (1, 3)")

    assert_equal [{x: 1, y: 3}], pizza_bot.drop_points
  end

  def test_initialized_with_two_drop_points
    pizza_bot = PizzaBot.new("5x5 (1, 3) (4, 4)")

    assert_equal [{x: 1, y: 3}, {x: 4, y: 4}], pizza_bot.drop_points
  end

  def test_initialized_with_invalid_gird
    assert_raises(ArgumentError) {PizzaBot.new("NxN (1, 3)")}
  end

  def test_initialized_with_non_numeric_drop_points
    assert_raises(ArgumentError) {PizzaBot.new("5x5 (X, Y)")}
  end

  def test_initialized_with_drop_points_out_of_range
    assert_raises(ArgumentError) {PizzaBot.new("5x5 (1, 3), (5, 5)")}
  end

  def test_directions_start_empty
    pizza_bot = PizzaBot.new("5x5 (1, 3)")

    assert_equal '', pizza_bot.directions
  end

  def test_five_by_five_calculate_directions_one_stop
    pizza_bot = PizzaBot.new("5x5 (1, 3)")
    pizza_bot.calculate_directions

    assert_equal 'ENNND', pizza_bot.directions
  end

  def test_five_by_five_calculate_directions_two_stops
    pizza_bot = PizzaBot.new("5x5 (1, 3) (4, 4)")
    pizza_bot.calculate_directions

    assert_equal 'ENNNDEEEND', pizza_bot.directions
  end

  def test_five_by_five_calculate_directions_three_stops
    pizza_bot = PizzaBot.new("5x5 (1, 3) (4, 4) (4, 2)")
    pizza_bot.calculate_directions

    assert_equal 'ENNNDEEENDSSD', pizza_bot.directions
  end

  def test_five_by_five_calculate_directions_nine_stops
    pizza_bot = PizzaBot.new("5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)")
    pizza_bot.calculate_directions

    assert_equal "NDSDENNNDEDESDESDNNNDSSDD", pizza_bot.directions
  end

  def test_six_by_six_calculate_directions_two_stops
    pizza_bot = PizzaBot.new("6x6 (0, 0) (1, 5)")
    pizza_bot.calculate_directions
    assert_equal 'DENNNNND', pizza_bot.directions
  end

end
