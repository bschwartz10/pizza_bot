class PizzaBot
  attr_reader :drop_points, :current_location, :directions

  def initialize(string)
    @drop_points = validate_drop_points(string[4..-1])
    @grid = validate_grid({width: string[0], height: string[2]})
    @current_location = {x: 0, y: 0}
    @directions = ''
  end

  def calculate_directions
    sort_ideal_path(drop_points).each {|drop_point| direct_to_drop_point(drop_point)}
  end

  private

  def validate_drop_points(drop_points)
    formatted_drop_points = drop_points.gsub(/[,()\s+]/, "")
    if only_integers?(formatted_drop_points)
      format_drop_points(formatted_drop_points)
    else
      raise ArgumentError.new("non-integer value detected")
    end
  end

  def only_integers?(drop_points)
    drop_points.scan(/\D/).empty?
  end

  def format_drop_points(drop_points)
    # format drop points into an array of key/value pairs i.e. [ {x: 1, y: 2}, {x: 2, y: 4} ]
    drop_points.scan(/../).map do |drop_point|
      {x: drop_point[0].to_i, y: drop_point[-1].to_i}
    end
  end

  def validate_grid(dimensions)
    # check if dimensions are integers
    if !(is_integer?(dimensions[:width]) && is_integer?(dimensions[:height]))
      raise ArgumentError.new("non-integer value detected")
    # check if dimensions are within the grid's range
    elsif !(valid_dimensions?(dimensions))
      raise ArgumentError.new("drop points are out of range for given grid")
    else
      dimensions
    end
  end

  def valid_dimensions?(dimensions)
    # calculate max width and max height
    max_width = dimensions[:width].to_i - 1
    max_height = dimensions[:height].to_i - 1

    # calculate largest drop point width/height
    largest_width = largest_dimension(:x)
    largest_height = largest_dimension(:y)

    # check to see if largest drop points are within current grid boundaries
    largest_width <= max_width && largest_height <= max_height
  end

  def largest_dimension(value)
    result = drop_points.map { |drop_point| drop_point[value] }
    result.max
  end

  def is_integer?(input)
    input.to_i.to_s == input
  end

  def direct_to_drop_point(drop_point)
    # figure out X distance and Y distance
    delta_x = drop_point[:x] - @current_location[:x]
    delta_y = drop_point[:y] - @current_location[:y]

    # take that distance and convert to a direction / add the direction to @directions
    @directions += convert_direction(delta_x, delta_y)

    # update @current_location
    @current_location[:x] = drop_point[:x]
    @current_location[:y] = drop_point[:y]
  end

  def convert_direction(delta_x, delta_y)
    # given a delta x and delta y, spit out the direction in a string
    x_direction = delta_x < 0 ? "W" : "E"
    y_direction = delta_y < 0 ? "S" : "N"
    (x_direction * (delta_x.abs)) + (y_direction * (delta_y.abs)) + "D"
  end

  def sort_ideal_path(drop_points)
    # sort route based on horizontal distance from starting point
    drop_points.sort_by {|drop_point| drop_point[:x]}
  end

end
