class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def upload
    people_upload = params[:people_upload]
    people_list_string = people_upload.read.to_s
    Person.uploadToPeople(people_list_string)
  end
end
