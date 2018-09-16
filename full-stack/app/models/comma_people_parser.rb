class CommaPeopleParser < PeopleParser
  def getDelimiter
    return ","
  end

  def splitAndParseLine(line)
    splitString = line.split(getDelimiter)
    if (splitString.length < 5)
      raise line + " must have 5 parameters"
    end
    @last_name = splitString[0]
    @first_name = splitString[1]
    @middle_initial = ""
    @pet = splitString[2]
    @favorite_color = splitString[3]
    @dob = splitString[4]
  end
end