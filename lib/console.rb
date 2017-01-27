require_relative "boltonizer"
require_relative "boltonizer_presenter"

class Console
  def initialize
    @boltonizer = Boltonizer.new
  end
  
  def start_session
    puts BoltonizerPresenter.greeting

    while command = gets.chomp
      boltonizer.do(command)
      puts "Boltonizer: #{boltonizer.response}"
    end
  rescue Boltonizer::Exit
    puts BoltonizerPresenter.goodbye_message
  end
  
  private

  attr_reader :boltonizer
end
