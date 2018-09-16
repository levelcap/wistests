class SpacePeopleParser < BasePeopleParser
  def getDelimiter
    return " "
  end

  def splitAndParseLine(line)
    splitString = line.split(getDelimiter)
    splitString = line.split(getDelimiter)
    if (splitString.length < 6)
      raise line + " must have 6 parameters"
    end
    @last_name = splitString[0]
    @first_name = splitString[1]
    @middle_initial = splitString[2]
    @pet = splitString[3]
    @dob = splitString[4]
    @favorite_color = splitString[5]
  end

  def parseParams
    @dob.gsub!('-', '/')
    case @pet
    when "C"
      @pet = "Cat"
    when "D"
      @pet = "Dog"
    when "B"
      @pet = "Both"
    else
      @pet = "None"
    end
    return
  end
end