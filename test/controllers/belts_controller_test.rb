require "test_helper"

class BeltsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @art = create(:art)
    @belt = create(:belt, art: @art)
  end

  test "should get new" do
    get new_art_belt_url(@art)
    assert_response :success
  end

  test "should create belt no image given" do
    belt_params = attributes_for(:belt, art: @art)

    assert_difference("Belt.count") do
      post art_belts_url(@art), params: {
        belt: belt_params
      }
    end

    assert_redirected_to art_belt_url(@art, Belt.order(:id).last)
  end

  test "should create belt good image given" do
    belt_params = attributes_for(:belt, art: @art, img: "test.png")

    assert_difference("Belt.count") do
      post art_belts_url(@art), params: {
        belt: belt_params
      }
    end
    
    assert_redirected_to art_belt_url(@art, Belt.order(:id).last)
  end

  test "create belt bad image given" do
    belt_params = attributes_for(:belt, art: @art, img: "bad_img.png")

    assert_no_difference("Belt.count") do
      post art_belts_url(@art), params: {
        belt: belt_params
      }
    end

    assert_response :unprocessable_entity
    assert_template :new
  end

  test "should show belt" do
    get art_belt_url(@art, @belt)
    assert_response :success
  end

  test "should get edit" do
    get edit_art_belt_url(@art, @belt)
    assert_response :success
  end

  test "should update belt no image given" do
    belt_params = attributes_for(:belt, art: @art)

    patch art_belt_url(@art, @belt), params: {
      belt: belt_params
    }

    assert_redirected_to art_belt_url(@art, @belt)
  end

  test "should update belt good image given" do
    belt_params = attributes_for(:belt, art: @art, img: "test.png")

    patch art_belt_url(@art, @belt), params: {
      belt: belt_params
    }

    assert_redirected_to art_belt_url(@art, @belt)
  end

  test "should update belt bad image given" do
    belt_params = attributes_for(:belt, art: @art, img: "bad_img.png")

    patch art_belt_url(@art, @belt), params: {
      belt: belt_params
    }

    assert_redirected_to edit_art_belt_url(@art, @belt)
  end
 
  test "should destroy belt" do
    assert_difference("Belt.count", -1) do
      delete art_belt_url(@art, @belt)
    end

    assert_redirected_to art_url(@art)
  end
end