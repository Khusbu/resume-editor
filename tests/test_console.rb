require_relative '../src/console'
require 'test/unit'

class TestConsole < Test::Unit::TestCase

  def test_add_with_wrong_number_of_arguments
    msg = Console.add("")
    assert_equal(Utility.argument_count_error_msg, msg)
  end

  def test_add_with_wrong_format_of_arguments
    msg = Console.add("name: Khusbu Mishra")
    assert_equal(Utility.argument_format_error_msg, msg)
  end

  def test_modify_with_wrong_number_of_arguments
    msg = Console.modify("")
    assert_equal(Utility.argument_count_error_msg, msg)
  end

  def test_modify_with_wrong_format_of_arguments
    msg = Console.modify("name: Khusbu Mishra")
    assert_equal(Utility.argument_format_error_msg, msg)
  end

  def test_delete_with_wrong_number_of_arguments
    msg = Console.delete("")
    assert_equal(Utility.argument_count_error_msg, msg)
  end

  def test_read_with_wrong_number_of_arguments
    msg = Console.read("")
    assert_equal(Utility.argument_count_error_msg, msg)
  end

  def test_create_resume_object
    resume_filepath = File.join(File.dirname(__FILE__), '/test_data.json')
    resume_object = Console.create_resume_object(resume_filepath)
    assert_not_nil(resume_object)
    assert(resume_object.instance_variable_defined?("@name"))
    assert(resume_object.instance_variable_defined?("@phone"))
  end

  def test_positive_scenarios
    resume_filepath = File.join(File.dirname(__FILE__), '/test_data.json')
    Console.create_resume_object(resume_filepath)

    arguments = ["location=Kolkata"]
    Console.add(arguments)
    assert_equal(Console.resume_object.instance_variable_get("@location"), "Kolkata")

    arguments = ["location=Bengaluru"]
    Console.modify(arguments)
    assert_equal(Console.resume_object.instance_variable_get("@location"), "Bengaluru")

    arguments = ["location"]

    msg = Console.read(arguments)
    assert_equal(msg, Utility.attribute_read_msg(arguments[0], "Bengaluru"))

    Console.delete(arguments)
    assert_equal(Console.resume_object.instance_variable_defined?("@#{arguments[0]}"), false)
  end
end
