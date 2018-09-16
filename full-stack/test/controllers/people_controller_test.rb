require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    response = get people_index_url
    assert_response :success
    Rails.logger.info(@people)
    Rails.logger.warn('Help')
    assert_equal Person.all, assigns(:people)
  end


  test "should be able to upload a pipe delimited file" do
    file = fixture_file_upload('files/pipe.txt', 'text/plain')
    post people_upload_url, params: { :people_upload => file }
    assert_response :success
 end
end
