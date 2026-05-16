require "test_helper"

class ArtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @art = create(:art)
  end

  test "should get index" do
    get arts_url
    assert_response :success
  end

  test "should get new" do
    get new_art_url
    assert_response :success
  end

  test "should create art" do
    art_params = attributes_for(:art)

    assert_difference("Art.count") do
      post arts_url, params: {
        art: art_params
      }
    end

    assert_redirected_to art_url(Art.last)
  end

  test "should show art" do
    get art_url(@art)
    assert_response :success
  end

  test "should get edit" do
    get edit_art_url(@art)
    assert_response :success
  end

  test "should update art" do
    art_params = attributes_for(:art)

    patch art_url(@art), params: {
      art: art_params
    }
    assert_redirected_to art_url(@art)
  end

  test "should destroy art" do
    assert_difference("Art.count", -1) do
      delete art_url(@art)
    end

    assert_redirected_to arts_url
  end
end