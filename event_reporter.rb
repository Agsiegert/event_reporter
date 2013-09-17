

class EventReporter
  def initialize
    puts "Initializing Event Reporter!"
  end

  def run
    puts "Welcome to Event Reporter!"

    command = ""

    while command != "quit"
      printf "enter command: "
      command = gets.chomp
      
  

      case command
        when 'quit' then puts "Quit"
        when 'queue clear' then
          #clears queue
          puts "The Queue is cleared: "
          #return to command

        # when "load" then 
        #   message = parts[2..-1].join(" ")
        #   direct_message(username, message)

        # when 'followers' then
        #   puts my_followers

        else 
          puts "Sorry, I dont't know how to \"#{command}\""
      end
    end
  end
end

 er = EventReporter.new
 er.run

#microblogger promts work
#

#Quue - 
  #hold stored values from previous search
  #a_list
#