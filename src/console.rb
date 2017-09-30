require_relative './resume'
require_relative './utility'

class Console

  class << self
    attr_reader :resume_object

    # start starts the console
    # creates the resume object using content store in ../resume.json
    # loops and waits for the command and executes them
    def start
      resume_filepath = File.join(File.dirname(__FILE__), '../resume.json')
      create_resume_object(resume_filepath)
      display_initial_message
      loop do
        display_prompt
        input = gets.chomp!
        next unless !input.empty?
        command, *params = input.strip.split(/\s/, 2)

        case command
        when /\Ahelp\z/i
          puts usage
        when /\Aadd\z/i
          puts add(params)
        when /\Amodify\z/i
          puts modify(params)
        when /\Adelete\z/i
          puts delete(params)
        when /\Aread\z/i
          puts read(params)
        when /\Adisplay\z/i
          puts display
        when /\Aquit\z/i
          quit
        else puts "You gave me #{command} -- I have no idea what to do with that."
        end
      end
    end

    # display_initial_message displays the message on console start
    def display_initial_message
      puts %{
        Welcome to `resume-editor`! You can edit the resume stored in resume.json file using a set of commands.
        To list the available commands and its usage, type `help`. Happy editing! :)
      }
    end

    # create_resume_object creates a resume object from a file content
    def create_resume_object(filepath)
      content = File.read(filepath)
      hash = JSON.parse(content)
      @resume_object = Resume.new(hash)
    end

    # display_prompt displays the prompt for resume-editor
    def display_prompt
      print "resume-editor>>> "
    end

    # usage returns help text to use the console
    def usage
      %{
        Usage: COMMAND [ARGS]

        Commands:
          help                                    Print this text
          add [attribute]=[value]                 Adds an attribute
          modify [attribute]=[value]              Modifies an attribute
          delete [attribute]                      Deletes an attribute
          read [attribute]                        Prints an attribute's value
          display                                 Pretty prints the resume object
          quit                                    Quits the console
      }
    end

    # add adds field and its value (sent as arguments) to the resume object
    def add(arguments)
      parsed_args, error_msg = Utility.parse_arguments(arguments)
      return error_msg if !error_msg.empty?
      return Utility.argument_format_error_msg if parsed_args.size < 2
      @resume_object.add(parsed_args[0], parsed_args[1])
    end

    # modify modifies field and its value (sent as arguments) to the resume object
    def modify(arguments)
      parsed_args, error_msg = Utility.parse_arguments(arguments)
      return  error_msg if !error_msg.empty?
      return Utility.argument_format_error_msg if parsed_args.size < 2
      @resume_object.modify(parsed_args[0], parsed_args[1])
    end

    # delete deletes a field and its value from the resume object
    def delete(arguments)
      parsed_args, error_msg = Utility.parse_arguments(arguments)
      return  error_msg if !error_msg.empty?
      @resume_object.delete(parsed_args[0])
    end

    # read reads a field value and prints it to the console
    def read(arguments)
      parsed_args, error_msg = Utility.parse_arguments(arguments)
      return  error_msg if !error_msg.empty?
      @resume_object.read(parsed_args[0])
    end

    # display displays all the fields of the resume object
    def display
      @resume_object.display
    end

    # quit quits the console
    def quit
      exit
    end

  end
end
