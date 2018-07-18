class PizzaBot
  attr_reader :width, :height, :max_dimensions, :coordinates, :directions

  def initialize(string)
    @width = string[0].to_i
    @height = string[2].to_i
    @coordinates = string[4..-1].gsub(/[()]/, "").scan(/.{1,5}/)
    @max_dimensions = {
                        max_x:  width - 1,
                        max_y: height - 1
                      }
    @directions = []
  end

  def calculate_directions
    current_x = 0
    current_y = 0

    coordinates.each do |coordinate|
      formatted_coordinate = coordinate.strip
      x_coordinate = formatted_coordinate[0].to_i # 1
      y_coordinate = formatted_coordinate[-1].to_i # 3

      if x_coordinate > max_dimensions[:max_x] ||
         y_coordinate > max_dimensions[:max_y]
         raise ArgumentError.new("Coordinates are out of range for given grid")
      end

      x_difference = x_coordinate - current_x
      y_difference = y_coordinate - current_y

      filter_directions('x-axis', x_difference, directions)
      filter_directions('y-axis', y_difference, directions)

      directions << 'D'
      current_x = x_coordinate
      current_y = y_coordinate
    end
    directions.join('')
  end

  private

  def filter_directions(type, difference, directions)
    if type == 'x-axis'
      if difference < 0
        add_directions(difference, 'W')
      elsif difference > 0
        add_directions(difference, 'E')
      end
    elsif type == 'y-axis'
      if difference < 0
        add_directions(difference, 'S')
      elsif difference > 0
        add_directions(difference, 'N')
      end
    end
  end

  def add_directions(difference, value)
    (difference.abs).times { directions << value }
  end

end
