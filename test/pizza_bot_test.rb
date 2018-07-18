require 'minitest/autorun'
require './lib/pizza_bot'

class PizzaBotTest < Minitest::Test
  attr_reader :pizza_bot

  def setup
    @pizza_bot = PizzaBot.new("5x5 (1, 3)")
  end

  def test_it_exists
    assert_instance_of PizzaBot, pizza_bot
  end

  def test_initialized_with_width
    assert_equal 5, pizza_bot.width
  end

  def test_initialized_with_height
    assert_equal 5, pizza_bot.height
  end

  def test_initialized_with_coordinates
    assert_equal ['1, 3'], pizza_bot.coordinates
  end

  def test_initialized_with_max_dimensions
    assert_equal ({max_x: 4, max_y: 4}), pizza_bot.max_dimensions
  end

  def test_directions_start_empty
    assert_equal [], pizza_bot.directions
  end

  def test_five_by_five_calculate_directions_one_stop
    assert_equal 'ENNND', pizza_bot.calculate_directions
  end

  def test_five_by_five_calculate_directions_two_stops
    pizza_bot_two = PizzaBot.new("5x5 (1, 3) (4, 4)")
    assert_equal 'ENNNDEEEND', pizza_bot_two.calculate_directions
  end

  def test_five_by_five_calculate_directions_three_stops
    pizza_bot_two = PizzaBot.new("5x5 (1, 3) (4, 4) (4, 2)")
    assert_equal 'ENNNDEEENDSSD', pizza_bot_two.calculate_directions
  end

  def test_five_by_five_calculate_directions_nine_stops
    pizza_bot_two = PizzaBot.new("5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)")
    assert_equal 'DENNNDEEENDSSDDWWWWSDEEENDWNDEESSD', pizza_bot_two.calculate_directions
  end

  def test_five_by_five_calculate_directions_out_of_range
    pizza_bot_two = PizzaBot.new("5x5 (0, 0) (1, 6) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)")
    assert_raises(ArgumentError) {pizza_bot_two.calculate_directions}
  end

  def test_six_by_six_calculate_directions_two_stops
    pizza_bot_two = PizzaBot.new("6x6 (0, 0) (1, 5)")
    assert_equal 'DENNNNND', pizza_bot_two.calculate_directions
  end

end
