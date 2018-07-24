# Pizza Bot

## Overview
This app delivers pizza to all the houses in the neighborhood based on cartesian plane directions.

### Dependencies
  * This app uses minitest for its testing library.

### Setup
To run this project, perform the following:
  1. `cd` into the project's directory
  3. Two rake commands have been set up to run the files
     - `rake delivery` - Run sample delivery
      - There are two delivery options to run in runner.rb
        1. The first option outputs a response based on the given input of 5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1) as requested in the spec.
        2. STDIN Option - The console asks for input from the user and outputs the correct directions based on the user input.  
     - `rake tests` - Run all tests

### Discussion
My goal was to keep the application simple while maintaining future flexibility. I created a PizzaBot class to house all my methods and created a coinciding test file to test its behavior. Since the API accepts a external string on initialization, I wanted to make sure I had a few validity checks in place. Throughout the initialization I check for non-numeric values for both the grid dimensions and drop points. I also check that the drop points are within the grid's limits.

After validating the new PizzaBot instance, I run the calculate directions method to generate a string with the correct cartesian plane directions. I chose to sort the drop points from the smallest x value to the greatest x value ( i.e (1, 4) (2, 4) (3, 4) ). I'm not sure if this is the most optimal way to sort the drop points but it did reduce the 9 stop route from 34 moves to 25 moves.

I do want to point out that in the spec the behavior seems to be the instance outputs the result string on initialization.
```
assertEqual(pizzabot("5x5 (1, 3) (4, 4)"), "ENNNDEEEND")
```
In my application I call calculate_directions to populate the @directions instance variable and then output the @directions array to display the result string. I chose this approach because it seems like the behavior specified in the spec is discouraged throughout the Ruby community (https://stackoverflow.com/questions/4888786/how-can-i-change-the-return-value-of-a-class-constructor-in-ruby).
