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
end
