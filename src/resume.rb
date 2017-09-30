require 'json'
require_relative './utility'

class Resume

  # initialize initialises resume object using hash
  def initialize(hash)
    hash.each do |key, value|
      instance_variable_set "@#{key}", value
    end
  end

  # add adds an attribute to the object
  def add(attribute, value)
    begin
      if instance_variable_defined?("@#{attribute}")
        return Utility.attribute_present_msg(attribute)
      else
        instance_variable_set "@#{attribute}", value
        return Utility.attribute_set_msg(attribute, value)
      end
    rescue => ex
      return ex.message
    end
  end

  # modify modifies an attribute of the object
  def modify(attribute, value)
    begin
      if instance_variable_defined?("@#{attribute}")
        instance_variable_set "@#{attribute}", value
        return Utility.attribute_set_msg(attribute, value)
      else
        return Utility.attribute_not_present_msg(attribute)
      end
    rescue => ex
      return ex.message
    end
  end

  # delete deletes an attribute of the object
  def delete(attribute)
    begin
      if instance_variable_defined?("@#{attribute}")
        remove_instance_variable("@#{attribute}")
        return Utility.attribute_deleted_msg(attribute)
      else
        return Utility.attribute_not_present_msg(attribute)
      end
    rescue => ex
      return ex.message
    end
  end

  # read reads an attribute of the object
  def read(attribute)
    begin
      if instance_variable_defined?("@#{attribute}")
        value = instance_variable_get("@#{attribute}")
        return Utility.attribute_read_msg(attribute, value)
      else
        return Utility.attribute_not_present_msg(attribute)
      end
    rescue => ex
      return ex.message
    end
  end

  # display displays all the attributes of the object in pretty JSON format 
  def display
    begin
      object_hash = self.instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }
      return JSON.pretty_generate(object_hash)
    rescue => ex
      return ex.message
    end
  end

end
