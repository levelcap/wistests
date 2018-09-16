class PipePeopleParser < PeopleParser
  def getDelimiter
    return "|"
  end

  def splitAndParseLine(line)
    splitString = line.split(getDelimiter)
    @first_name = splitString[0]
    @last_name = splitString[1]
    @middle_initial = splitString[2]
    @pet = splitString[3]
    @dob = splitString[4]
    @favorite_color = splitString[5]
  end

  def parseParams
    @dob.gsub!('-', '/')
    return
  end
end