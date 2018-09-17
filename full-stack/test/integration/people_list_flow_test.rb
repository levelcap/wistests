require 'test_helper'

class PeopleListFlowTest < ActionDispatch::IntegrationTest
  test "can see the people page with generated Person fixtures" do
    get "/"
    # Header should correctly count fixture people
    assert_select "h1", "2 People"
    # Table should have one row per person
    assert_select "#people-table tbody tr", 2
  end


  test "can post new people then view Person page with an updated count" do
    file = fixture_file_upload('files/pipe.txt', 'text/plain')
    post people_upload_url, params: { :people_upload => file }
    assert_response :success
    get "/"
    # Header should have an updated count to account for 3 new people
    assert_select "h1", "5 People"
    # Table should contain 3 new person rows
    assert_select "#people-table tbody tr", 5
  end
end
