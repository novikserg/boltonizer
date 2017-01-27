class BoltonizerPresenter
  def initialize(object)
    @object = object
  end
  
  def self.greeting
    "Hey there! I am Michael Bolton put inside a Terminator shell. Allowed commands: #{Command.formatted_allowed_commands}."
  end

  def self.goodbye_message
    "Beep-blop! Don't forget to check my latest album out!"
  end

  def not_placed
    "Please PLACE me on the table first."
  end

  def unknown_command
    "Unknown command. Commands I understand: #{Command.formatted_allowed_commands}"
  end

  def incorrect_coordinates
     "Incorrect coordinates. Don't forget I am inside 5x5 grid!"
  end
  
  def report
    coordinates = @object.coordinates
    "X: #{coordinates.x}, Y: #{coordinates.y}, direction: #{coordinates.direction.upcase}"
  end

  def default
    "Done."
  end

  alias place default
  alias move default
  alias left default
  alias right default
end
