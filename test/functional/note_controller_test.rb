require 'test_helper'

class NoteControllerTest < ActionController::TestCase
  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get view" do
    get :view
    assert_response :success
  end

  test "should get addParagraph" do
    get :addParagraph
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
