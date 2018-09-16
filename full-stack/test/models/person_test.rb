require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "PipePeopleParser is called twice for a two line string value separated by pipes" do
    testString = "one|two|three\nfour|five|six"
    mock = Minitest::Mock.new
    mock.expect :parseLine, true, ["one|two|three"]
    mock.expect :parseLine, true, ["four|five|six"]

    PipePeopleParser.stub :new, mock do
      Person.uploadToPeople(testString)
    end

    assert_mock mock
  end

  test "SpacePeopleParser is called twice for a two line string value separated by spaces" do
    testString = "one two three\nfour five six"
    mock = Minitest::Mock.new
    mock.expect :parseLine, true, ["one two three"]
    mock.expect :parseLine, true, ["four five six"]

    SpacePeopleParser.stub :new, mock do
      Person.uploadToPeople(testString)
    end

    assert_mock mock
  end

  test "CommaPeopleParser is called twice for a two line string value separated by commas" do
    testString = "one,two,three\nfour,five,six"
    mock = Minitest::Mock.new
    mock.expect :parseLine, true, ["one,two,three"]
    mock.expect :parseLine, true, ["four,five,six"]

    CommaPeopleParser.stub :new, mock do
      Person.uploadToPeople(testString)
    end

    assert_mock mock
  end

  test "PipePeopleParser returns two people and one error for input with one bad row" do
    testString = "one|two|three|four|five|six\nbadlyformattedrow\none|two|three|four|five|six"
    response = Person.uploadToPeople(testString)
    assert_equal(response[:people].length, 2)
    assert_equal(response[:errors].length, 1)
  end

  test "CommaPeopleParser returns two errors for two bad rows" do
    testString = "one|two|three\nbadrowdifferentformat"
    response = Person.uploadToPeople(testString)
    assert_equal(response[:people].length, 0)
    assert_equal(response[:errors].length, 2)
  end
end
