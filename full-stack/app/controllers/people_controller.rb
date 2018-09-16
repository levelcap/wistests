class PeopleController < ApplicationController
  def index
  end

  def upload
    people_upload = params[:people_upload]
    people_list_string = people_upload.read.to_s
    Person.uploadToPeople(people_upload)
  end
end
