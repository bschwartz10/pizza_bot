require './lib/pizza_bot'

pizza_bot = PizzaBot.new("5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)")
pizza_bot.calculate_directions
p pizza_bot.directions

# **** STDIN Solution ****
# puts "Please enter directions for our PizzaBot using the following format: 5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)"
# input_string = STDIN.gets.chomp
# pizza_bot = PizzaBot.new(input_string)
# pizza_bot.calculate_directions
# route = pizza_bot.directions
# p "The route for those drop points is #{route}"
