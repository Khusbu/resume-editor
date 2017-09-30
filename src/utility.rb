module Utility
  class << self
    def parse_arguments(arguments)
      args = []
      return args, argument_count_error_msg if (arguments.nil? or arguments.empty? or arguments.size < 1)
      if arguments[0].include?("=")
        begin
          args = arguments[0].split("=", 2)
        rescue => ex
          return args, ex.message
        end
      else
        args[0] = arguments[0]
      end
      args = args.collect{|x| x.strip.tr('""', '') || x }
      return args, ""
    end

    def argument_count_error_msg
      "error:  wrong number of arguments (given 0 required 1)"
    end

    def argument_format_error_msg
      "error:  wrong argument format. Use attribute=value format."
    end

    def attribute_not_present_msg(attribute)
      "error: `#{attribute}` not present in resume"
    end

    def attribute_set_msg(attribute, value)
      "success: `#{attribute}` set to `#{value}`"
    end

    def attribute_deleted_msg(attribute)
      "success: `#{attribute}` deleted from the resume"
    end

    def attribute_present_msg(attribute)
      "error: `#{attribute}` already present. Use `modify` to change its value."
    end

    def attribute_read_msg(attribute, value)
      "#{attribute} = #{value}"
    end
  end
end
