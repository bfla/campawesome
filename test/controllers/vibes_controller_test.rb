require 'test_helper'

class VibesControllerTest < ActionController::TestCase
  setup do
    @vibe = vibes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vibes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vibe" do
    assert_difference('Vibe.count') do
      post :create, vibe: { campsite_id: @vibe.campsite_id, tribe_id: @vibe.tribe_id }
    end

    assert_redirected_to vibe_path(assigns(:vibe))
  end

  test "should show vibe" do
    get :show, id: @vibe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vibe
    assert_response :success
  end

  test "should update vibe" do
    patch :update, id: @vibe, vibe: { campsite_id: @vibe.campsite_id, tribe_id: @vibe.tribe_id }
    assert_redirected_to vibe_path(assigns(:vibe))
  end

  test "should destroy vibe" do
    assert_difference('Vibe.count', -1) do
      delete :destroy, id: @vibe
    end

    assert_redirected_to vibes_path
  end
end
