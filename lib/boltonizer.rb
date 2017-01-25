require_relative "command"
require_relative "coordinates"
require "forwardable"

class Boltonizer
  class Exit < StandardError; end

  extend Forwardable

  attr_accessor :response, :coordinates

  def ask(raw_command)
    self.response = nil
    self.command = Command.new(raw_command)

    if !command.exit? && not_placed?
      self.response = "Please PLACE me on the table first."
      return
    end

    perform_command
    self.response ||= "Done."
  rescue Command::Invalid
    self.response = "Unknown command. Commands I understand: #{Command.allowed_commands_names}"
  rescue Coordinates::OutsideTableError
    self.response = "Incorrect coordinates. Don't forget I am inside 5x5 grid!"
  end

  def_delegators :coordinates, :move, :left, :right

  def place
    self.coordinates = Coordinates.new(command.details)
  end
  
  def report
    self.response = "X: #{coordinates.x}, Y: #{coordinates.y}, direction: #{coordinates.direction.upcase}" # upcase part would be in a decorator
  end

  def exit
    raise Exit
  end
    
  def greeting
    "Hey there! I am Michael Bolton put inside a Terminator shell. Allowed commands: #{Command.allowed_commands_names}."
  end
  
  def goodbye_message
    "Beep-blop! Don't forget to check my latest album out!"
  end
  
  private
  
  attr_accessor :command
  
  def perform_command
    send(command.command)
  end
  
  def not_placed?
    coordinates.nil? && !command.place?
  end
end
