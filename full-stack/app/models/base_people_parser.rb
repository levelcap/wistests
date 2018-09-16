# Base class with a default implementation of string-to-Person parsing
class BasePeopleParser
  def initialize
    @first_name = ""
    @last_name = ""
    @middle_initial = ""
    @pet = ""
    @dob = ""
    @favorite_color = ""
  end

  # Takes a string, splits it based on the given delimter and applies any special parameter
  # parsing rules (i.e. dates should be slash-delimited instead of hyphenated), the creates
  # a new Person in sqlite
  def parseLine(line)
    splitAndParseLine(line)
    parseParams()
    newPerson = Person.create(
      :first_name => @first_name,
      :last_name => @last_name,
      :middle_initial => @middle_initial,
      :pet => @pet,
      :dob => @dob,
      :favorite_color => @favorite_color)
    return newPerson
  end

  def getDelimiter
    return "delimiter"
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
    return
  end
end