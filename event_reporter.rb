

class EventReporter
  def initialize
    puts "Initializing Event Reporter!"
  end

  def run
    command = ""

    while command != "q"
      printf "Please enter command: "
      command = gets.chomp
    end
  end
end

a = EventReporter.new
a.run

#microblogger promts work
#

#Quue - 
  #hold stored values from previous search
  #a_list
#