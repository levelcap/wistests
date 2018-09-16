class CommaPeopleParser < PeopleParser
  def getDelimiter
    return " "
  end

  def splitAndParseLine(line)
    splitString = line.split(getDelimiter)
    @last_name = splitString[0]
    @first_name = splitString[1]
    @middle_initial = ""
    @pet = splitString[2]
    @favorite_color = splitString[3]
    @dob = splitString[4]
  end
end