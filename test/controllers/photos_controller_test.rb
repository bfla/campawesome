require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  setup do
    @photo = photos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photo" do
    assert_difference('Photo.count') do
      post :create, photo: { campsite_id: @photo.campsite_id, caption: @photo.caption, city_id: @photo.city_id, destination_id: @photo.destination_id, license_text: @photo.license_text, license_type: @photo.license_type, state_id: @photo.state_id, title: @photo.title, user_id: @photo.user_id }
    end

    assert_redirected_to photo_path(assigns(:photo))
  end

  test "should show photo" do
    get :show, id: @photo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @photo
    assert_response :success
  end

  test "should update photo" do
    patch :update, id: @photo, photo: { campsite_id: @photo.campsite_id, caption: @photo.caption, city_id: @photo.city_id, destination_id: @photo.destination_id, license_text: @photo.license_text, license_type: @photo.license_type, state_id: @photo.state_id, title: @photo.title, user_id: @photo.user_id }
    assert_redirected_to photo_path(assigns(:photo))
  end

  test "should destroy photo" do
    assert_difference('Photo.count', -1) do
      delete :destroy, id: @photo
    end

    assert_redirected_to photos_path
  end
end
