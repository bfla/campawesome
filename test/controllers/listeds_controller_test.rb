require 'test_helper'

class ListedsControllerTest < ActionController::TestCase
  setup do
    @listed = listeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:listeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create listed" do
    assert_difference('Listed.count') do
      post :create, listed: { campsite_id: @listed.campsite_id, list_id: @listed.list_id }
    end

    assert_redirected_to listed_path(assigns(:listed))
  end

  test "should show listed" do
    get :show, id: @listed
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @listed
    assert_response :success
  end

  test "should update listed" do
    patch :update, id: @listed, listed: { campsite_id: @listed.campsite_id, list_id: @listed.list_id }
    assert_redirected_to listed_path(assigns(:listed))
  end

  test "should destroy listed" do
    assert_difference('Listed.count', -1) do
      delete :destroy, id: @listed
    end

    assert_redirected_to listeds_path
  end
end
