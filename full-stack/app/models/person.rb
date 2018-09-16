class Person < ApplicationRecord
  def self.uploadToPeople(people_list_string)
    if people_list_string.include? "|"
      parser = PipePeopleParser.new
    elsif people_list_string.include? ","
      parser = CommaPeopleParser.new
    else
      parser = SpacePeopleParser.new
    end
    people_list_string.each_line do |line|
      parser.parseLine(line.strip)
    end
  end
end
