require 'test_helper'

class SpacePeopleParserTest < ActiveSupport::TestCase
  test "SpacePeopleParser raises an error when passed a string with too few parameters" do
    testString = "one two three"
    parser = SpacePeopleParser.new
    exception = assert_raises StandardError do
      parser.parseLine(testString)
    end
    assert_equal(testString + " must have 6 parameters", exception.message)
  end

  test "SpacePeopleParser returns a Person when passed a valid string" do
    testString = "Cohen Dave S B 4-23-1982 Green"
    parser = SpacePeopleParser.new
    person = parser.parseLine(testString)
    assert_equal("Dave", person.first_name)
    assert_equal("Cohen", person.last_name)
    assert_equal("S", person.middle_initial)
    assert_equal("Both", person.pet)
    assert_equal("4/23/1982", person.dob)
    assert_equal("Green", person.favorite_color)
  end

end
