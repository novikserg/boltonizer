class Coordinates
  class OutsideTableError < StandardError; end

  attr_accessor :x, :y, :direction
  
  def initialize(coordinates)
    @x, @y = coordinates[0].to_i, coordinates[1].to_i
    @direction = coordinates[2].downcase.to_sym
    validate
  end

  def self.directions_names
    directions.map{ |direction| direction.to_s.upcase } # that would be in a decorator too
  end

  def move
    new_x, new_y = x, y

    case direction
      when :north then new_y += 1
      when :east  then new_x += 1
      when :south then new_y -= 1
      when :west  then new_x -= 1
    end

    raise OutsideTableError if outside_grid?(new_x, new_y)

    self.x, self.y = new_x, new_y
  end
  
  def left
    self.direction = new_direction(self.class.clockwise_directions)
  end
    
  def right
    self.direction = new_direction(self.class.clockwise_directions.reverse)
  end

  private

  def self.directions
    %i(south north west east)
  end
  
  def self.clockwise_directions
    %i(north west south east)
  end

  def validate
    raise OutsideTableError if outside_grid?(x, y)
  end

  def outside_grid?(x, y)
    [x, y].any? { |coordinate| coordinate > 5 || coordinate < 0 }
  end
  
  def new_direction(rotations)
    rotations[(rotations.find_index(direction) + 1) % rotations.length]
  end
end
