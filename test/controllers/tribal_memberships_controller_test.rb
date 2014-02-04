require 'test_helper'

class TribalMembershipsControllerTest < ActionController::TestCase
  setup do
    @tribal_membership = tribal_memberships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tribal_memberships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tribal_membership" do
    assert_difference('TribalMembership.count') do
      post :create, tribal_membership: { tribe_id: @tribal_membership.tribe_id, user_id: @tribal_membership.user_id }
    end

    assert_redirected_to tribal_membership_path(assigns(:tribal_membership))
  end

  test "should show tribal_membership" do
    get :show, id: @tribal_membership
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tribal_membership
    assert_response :success
  end

  test "should update tribal_membership" do
    patch :update, id: @tribal_membership, tribal_membership: { tribe_id: @tribal_membership.tribe_id, user_id: @tribal_membership.user_id }
    assert_redirected_to tribal_membership_path(assigns(:tribal_membership))
  end

  test "should destroy tribal_membership" do
    assert_difference('TribalMembership.count', -1) do
      delete :destroy, id: @tribal_membership
    end

    assert_redirected_to tribal_memberships_path
  end
end
