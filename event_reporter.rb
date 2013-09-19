require './queue'
require 'csv'
require 'pry'

class PhoneNumber
  attr_accessor :phone_number
  def initialize(input = nil)
    @phone_number = clean_phone_number(input)
  end
  def clean_phone_number(number)
    if number
      number = number.scan(/[0-9]/).join
      if number.length == 11 && number.start_with?("1")
        number = number[1..-1]
      end
      if number.length != 10
        number = "0000000000"
      end 
      return number
    end
  end
end

class Zipcode
  attr_accessor :zipcode
  def initialize(input = nil)
    @zipcode = clean_zipcode(input)
  end
  def clean_zipcode(zipcode)
    zipcode = zipcode.to_s.rjust(5,"0")[0..4]
    return zipcode
  end
end

class Attendee
  attr_accessor :first_name, :last_name, :zipcode, :phone_number, :email_address, :street, :city, :state
  def initialize(input = {})
    @first_name   = input[:first_name]
    @last_name    = input[:last_name]
    @zipcode      = input[:zipcode]
    @phone_number = input[:phone_number]
    @email_address= input[:email_address]
    @street       = input[:street]
    @city         = input[:city]
    @state        = input[:state]

  end
end

class EventReporter
  attr_accessor :attendee_list, :result_queue
  def initialize
    puts "Initializing Event Reporter!"
    @attendee_list = []
    @result_queue = []
  end
  def load_file(filename)
    contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
    contents.each do |row|
      first_name    = row[:first_name]
      last_name     = row[:last_name]
      phone_number  = row[:homephone]
      zipcode       = row[:zipcode]
      email_address = row[:email_address]
      street        = row[:street]
      city          = row[:city]
      state         = row[:state]
      input         = {:first_name => first_name, :last_name => last_name, :phone_number => phone_number, :zipcode => zipcode, :email_address => email_address, :street => street, :city => city, :state => state}
      #:regdate, :first_name, :last_name, :email_address, :homephone, :street, :city, :state, :zipcode]
      attendee = Attendee.new(input)
      @attendee_list.push(attendee)
    end
  end

  def print_results
    @result_queue.each do |result|
      puts "#{result.first_name} #{result.last_name} #{result.phone_number} #{result.zipcode} #{result.email_address} #{result.street} #{result.city} #{result.state}"
    end
  end

  def clear_queue
    @result_queue = []
  end

  def find(attribute, criteria)
    #go through each object in attendee_list, find objects with matching criteria
    clear_queue
    case attribute
      when "first_name" then
        #find all objects with criteria as a first_name
        @attendee_list.each do |attendee|
          if attendee.first_name == criteria
            @result_queue.push attendee
          end
        end
        print_results
      when "last_name" then
        #find all objects with cirteria as a last_name
        @attendee_list.each do |attendee|
          if attendee.last_name == criteria
            @result_queue.push attendee
          end
        end
        print_results
      when "phone_number" then
        @attendee_list.each do |attendee|
          if attendee.phone_number == criteria
            @result_queue.push attendee
          end
        end
        print_results
      when "zipcode" then
        @attendee_list.each do |attendee|
          if attendee.zipcode == criteria
            @result_queue.push attendee
          end
        end
        print_results
      when "email_address" then
        @attendee_list.each do |attendee|
          if attendee.email_address == criteria
            @result_queue.push attendee
          end
        end
        print_results
      when "street" then
        @attendee_list.each do |attendee|
          if attendee.street == criteria
            @result_queue.push attendee
          end
        end
        print_results
      when "city" then
        @attendee_list.each do |attendee|
          if attendee.city == criteria
            @result_queue.push attendee
          end
        end
        print_results
      when "state" then
        @attendee_list.each do |attendee|
          if attendee.state == criteria
            @result_queue.push attendee
          end
        end
        print_results
        ####contiue for all attributes
    end
  end

  def help_description(help_command)
    help_command = help_command.join(" ")

    case help_command
      when "load" then
        puts "load: loads the CSV file, defaults to event_attendees.csv ."
      when "queue count" then
        puts "queue_count: shows number of records loaded in queue."
      when "queue clear" then
        puts "queue_clear:  Clears the queue of records."
      when "queue print" then
        puts "print: Prints a tab delimited data table with header row."
      when "queue print by" then
        puts "print by: Prints the data table sorted by the specific attribute laoded"
      when "queue save to" then
        puts "queue save to: Exports the current queue to the specified filename as a CSV."
      when "find" then
        puts "find: needs <attribute> and <criteria>, loads the queue with all records matching the criteria for the given attribute."  
      else
        puts "Here is a list of help commands: ", "Help", "quit", "load", "find", "queue_count", "queue_clear"
    end
  end
  def queue_command(queue_command)

    case queue_command
    when "count" then 
      puts result_queue.count
    when "clear" then
      clear_queue
          puts "The queue is cleared!"
    when "print" then
      puts "***I haven't worked on printing yet***"
      #not yet thought about
      #queue print by <attribute>
      #queue save to <filename.csv>
    end
  end

  def run
    puts "Welcome to Event Reporter!"

    command = ""

    while command != "quit"
      printf "enter command: "
      input = gets.chomp.split
      command = input[0]
      
      case command

        when 'quit' then 
          puts "Goodbye!"
        when 'load' then 
          puts "Loading file"
          #promp user for file name
          filename = "./event_attendees.csv"
          load_file(filename)
        when 'find' then 
          puts "find"
          attribute = input[1]
          criteria = input[2]
            find(attribute, criteria)
        when 'queue' then
          queue_command = input[1]
            queue_command(queue_command)
        when 'help' then
          help_command = input[1..-1]
            help_description(help_command)
        else 
          puts "Sorry, I don't know how to \"#{command}\""
      end
    end
  end
end

 er = EventReporter.new
 er.run
