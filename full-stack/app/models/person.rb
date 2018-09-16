class Person < ApplicationRecord
  # Takes a multi-line string input and attemps to parse it into Person models
  def self.uploadToPeople(people_list_string)
    response = {
      :people => Array.new,
      :errors => Array.new
    }

    if people_list_string.include? "|"
      parser = PipePeopleParser.new
    elsif people_list_string.include? ","
      parser = CommaPeopleParser.new
    else
      parser = SpacePeopleParser.new
    end
    people_list_string.each_line do |line|
      begin
        person = parser.parseLine(line.strip)
        response[:people].push(person)
      rescue StandardError => e
        response[:errors].push(e.message)
      end
    end
    return response
  end
end
