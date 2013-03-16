require 'test_helper'

class ParagraphControllerTest < ActionController::TestCase
  test "should get modify" do
    get :modify
    assert_response :success
  end

  test "should get addLink" do
    get :addLink
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get get" do
    get :get
    assert_response :success
  end

end
