require 'test_helper'

class ElasticSearchControllerTest < ActionController::TestCase
  test "should get suggestion" do
    get :suggestion
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

end
