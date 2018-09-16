require 'test_helper'

class PipePeopleParserTest < ActiveSupport::TestCase
  test "PipePeopleParser raises an error when passed a string with too few parameters" do
    testString = "one|two|three"
    parser = PipePeopleParser.new
    exception = assert_raises StandardError do
      parser.parseLine(testString)
    end
    assert_equal(testString + " must have 6 parameters", exception.message)
  end

  test "PipePeopleParser returns a Person when passed a valid string" do
    testString = "Evelo|Dalila|G|None|Blue|6-3-1968"
    parser = PipePeopleParser.new
    person = parser.parseLine(testString)
    assert_equal("Dalila", person.first_name)
    assert_equal("Evelo", person.last_name)
    assert_equal("G", person.middle_initial)
    assert_equal("None", person.pet)
    assert_equal("6/3/1968", person.dob)
    assert_equal("Blue", person.favorite_color)
  end

end
