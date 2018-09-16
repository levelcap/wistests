class Person < ApplicationRecord
  def self.uploadToPeople(people_list_string)
    errors = Array.new
    if people_list_string.include? "|"
      parser = PipePeopleParser.new
    elsif people_list_string.include? ","
      parser = CommaPeopleParser.new
    else
      parser = SpacePeopleParser.new
    end
    people_list_string.each_line do |line|
      begin
        parser.parseLine(line.strip)
      rescue StandardError => e
        errors.push(message)
      end
    end
  end
end
