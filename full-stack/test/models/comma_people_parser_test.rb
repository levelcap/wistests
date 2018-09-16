require 'test_helper'

class CommaPeopleParserTest < ActiveSupport::TestCase
  test "CommaPeopleParser raises an error when passed a string with too few parameters" do
    testString = "one,two,three"
    parser = CommaPeopleParser.new
    exception = assert_raises StandardError do
      parser.parseLine(testString)
    end
    assert_equal(testString + " must have 5 parameters", exception.message)
  end

  test "CommaPeopleParser returns a Person when passed a valid string" do
    testString = "Cohen,Dave,Both,Green,4/23/1982"
    parser = CommaPeopleParser.new
    person = parser.parseLine(testString)
    assert_equal("Dave", person.first_name)
    assert_equal("Cohen", person.last_name)
    assert_equal("", person.middle_initial)
    assert_equal("Both", person.pet)
    assert_equal("4/23/1982", person.dob)
    assert_equal("Green", person.favorite_color)
  end

end
