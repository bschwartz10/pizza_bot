require './lib/pizza_bot'

pizza_bot = PizzaBot.new("5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)")
pizza_bot.calculate_directions
p pizza_bot.directions
# STDIN Solution
# puts "Please enter directions for our PizzaBot using the following format: 5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)"
# string = STDIN.gets.chomp
# p PizzaBot.new(string).calculate_directions
