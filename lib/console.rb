require_relative "boltonizer"

class Console
  def initialize
    @boltonizer = Boltonizer.new
  end
  
  def start_session
    puts boltonizer.greeting

    while command = gets.chomp
      boltonizer.ask(command)
      puts "Boltonizer: #{boltonizer.response}"
    end
  rescue Boltonizer::Exit
    puts boltonizer.goodbye_message
  end
  
  private

  attr_reader :boltonizer
end
