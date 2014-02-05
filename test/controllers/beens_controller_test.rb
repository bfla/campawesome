require 'test_helper'

class BeensControllerTest < ActionController::TestCase
  setup do
    @been = beens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:beens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create been" do
    assert_difference('Been.count') do
      post :create, been: { campsite_id: @been.campsite_id, user_id: @been.user_id }
    end

    assert_redirected_to been_path(assigns(:been))
  end

  test "should show been" do
    get :show, id: @been
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @been
    assert_response :success
  end

  test "should update been" do
    patch :update, id: @been, been: { campsite_id: @been.campsite_id, user_id: @been.user_id }
    assert_redirected_to been_path(assigns(:been))
  end

  test "should destroy been" do
    assert_difference('Been.count', -1) do
      delete :destroy, id: @been
    end

    assert_redirected_to beens_path
  end
end
