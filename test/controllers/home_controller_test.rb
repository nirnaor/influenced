require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get start" do
    get home_start_url
    assert_response :success
  end

  test "should get search" do
    get home_search_url
    assert_response :success
  end

  test "should get influences" do
    get home_influences_url
    assert_response :success
  end

end
