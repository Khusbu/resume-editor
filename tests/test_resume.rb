require_relative '../src/resume'
require 'test/unit'
require_relative '../src/utility'

class TestResume < Test::Unit::TestCase

  def test_initialize
    resume_object = Resume.new({"name": "Khusbu Mishra"})
    assert_equal(resume_object.instance_variable_get("@name"), "Khusbu Mishra")
  end

  def test_add_success
    resume_object = Resume.new({"name": "Khusbu Mishra"})
    attribute, value = "phone", "9999999999"
    msg = resume_object.add(attribute, value)
    assert_equal(msg, Utility.attribute_set_msg(attribute, value))
    assert_equal(resume_object.instance_variable_get("@#{attribute}"), value)
  end

  def test_add_failure
    resume_object = Resume.new({"name": "Khusbu Mishra"})
    attribute, value = "name", "XYZ Mishra"
    msg = resume_object.add(attribute, value)
    assert_equal(msg, Utility.attribute_present_msg(attribute))
    assert_equal(resume_object.instance_variable_get("@#{attribute}"), "Khusbu Mishra")
  end

  def test_modify_success
    resume_object = Resume.new({"name": "Khusbu Mishra"})
    attribute, value = "name", "XYZ Mishra"
    msg = resume_object.modify(attribute, value)
    assert_equal(msg, Utility.attribute_set_msg(attribute, value))
    assert_equal(resume_object.instance_variable_get("@#{attribute}"), value)
  end

  def test_modify_failure
    resume_object = Resume.new({"name": "Khusbu Mishra"})
    attribute, value = "phone", "9999999999"
    msg = resume_object.modify(attribute, value)
    assert_equal(msg, Utility.attribute_not_present_msg(attribute))
    assert_equal(resume_object.instance_variable_defined?("@#{attribute}"), false)
  end

  def test_delete_success
    resume_object = Resume.new({"name": "Khusbu Mishra"})
    attribute = "name"
    msg = resume_object.delete(attribute)
    assert_equal(msg, Utility.attribute_deleted_msg(attribute))
    assert_equal(resume_object.instance_variable_defined?("@#{attribute}"), false)
  end

  def test_delete_failure
    resume_object = Resume.new({"name": "Khusbu Mishra"})
    attribute = "phone"
    msg = resume_object.delete(attribute)
    assert_equal(msg, Utility.attribute_not_present_msg(attribute))
    assert_equal(resume_object.instance_variable_defined?("@#{attribute}"), false)
  end

  def test_read_success
    resume_object = Resume.new({"name": "Khusbu Mishra"})
    attribute, value = "name", "Khusbu Mishra"
    msg = resume_object.read(attribute)
    assert_equal(msg, Utility.attribute_read_msg(attribute, value))
  end

end
