class Command
  class Invalid < StandardError; end

  ALLOWED_COMMANDS = %i(place move exit left right report)

  attr_reader :command_name

  def initialize(raw_command)
    @raw_command = raw_command
    @command_name, @raw_details = raw_command.split(" ")
    @command_name = @command_name.downcase.to_sym if @command_name
    validate
  end
    
  def details
    parsed_details.captures
  end

  def self.formatted_allowed_commands
    ALLOWED_COMMANDS.map(&:upcase).join(", ")
  end

  ALLOWED_COMMANDS.each do |allowed_command|
    define_method "#{allowed_command}?" do
      command_name == allowed_command
    end
  end

  private

  attr_reader :raw_command, :raw_details

  def validate
    raise Invalid if command_name.nil? || !ALLOWED_COMMANDS.include?(command_name)
    raise Invalid if place? && incorrect_place_format?
  end

  def incorrect_place_format?
    return true if raw_details.nil? || parsed_details.nil?
  end

  def parsed_details
    @parsed_details ||= raw_details.match(/^(\d),(\d),(#{Coordinates.directions_names.join("|")})$/)
  end
end
