require 'test_helper'

class WantsControllerTest < ActionController::TestCase
  setup do
    @want = wants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create want" do
    assert_difference('Want.count') do
      post :create, want: { campsite_id: @want.campsite_id, user_id: @want.user_id }
    end

    assert_redirected_to want_path(assigns(:want))
  end

  test "should show want" do
    get :show, id: @want
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @want
    assert_response :success
  end

  test "should update want" do
    patch :update, id: @want, want: { campsite_id: @want.campsite_id, user_id: @want.user_id }
    assert_redirected_to want_path(assigns(:want))
  end

  test "should destroy want" do
    assert_difference('Want.count', -1) do
      delete :destroy, id: @want
    end

    assert_redirected_to wants_path
  end
end
