require_relative "command"
require_relative "coordinates"
require_relative "boltonizer_presenter"

require "forwardable"

class Boltonizer
  class NotPlacedError < StandardError; end
  class Exit < StandardError; end

  extend Forwardable

  attr_accessor :response, :coordinates, :direction

  def initialize
    @presenter = BoltonizerPresenter.new(self)
  end

  def do(raw_command)
    run_command(raw_command)
    set_successful_response
  rescue Coordinates::OutsideTableError
    @response = presenter.incorrect_coordinates
  rescue Command::Invalid
    @response = presenter.unknown_command
  rescue NotPlacedError
    @response = presenter.not_placed
  end
  
  private
  
  attr_reader :command, :presenter
    
  def_delegators :coordinates, :move, :left, :right

  def run_command(raw_command)
    @command = Command.new(raw_command)
    if !command.exit? && !command.place? && coordinates.nil?
      raise NotPlacedError
    end
    send(command.command_name)
  end
  
  def set_successful_response
    @response = presenter.public_send(command.command_name)
  end

  def place
    @coordinates = Coordinates.new(*command.details)
  end
  
  def report
  end
  
  def exit
    raise Exit
  end
end
