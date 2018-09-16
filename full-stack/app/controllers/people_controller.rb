class PeopleController < ApplicationController
  # TODO: Paginate requests rather than returning the entire table
  def index
    @people = Person.all
  end

  def upload
    people_upload = params[:people_upload]
    people_list_string = people_upload.read.to_s
    people = Person.uploadToPeople(people_list_string)
    render :json => people
  end
end
