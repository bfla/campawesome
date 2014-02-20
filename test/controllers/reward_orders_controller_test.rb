require 'test_helper'

class RewardOrdersControllerTest < ActionController::TestCase
  setup do
    @reward_order = reward_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reward_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reward_order" do
    assert_difference('RewardOrder.count') do
      post :create, reward_order: { product_id: @reward_order.product_id, user_id: @reward_order.user_id }
    end

    assert_redirected_to reward_order_path(assigns(:reward_order))
  end

  test "should show reward_order" do
    get :show, id: @reward_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reward_order
    assert_response :success
  end

  test "should update reward_order" do
    patch :update, id: @reward_order, reward_order: { product_id: @reward_order.product_id, user_id: @reward_order.user_id }
    assert_redirected_to reward_order_path(assigns(:reward_order))
  end

  test "should destroy reward_order" do
    assert_difference('RewardOrder.count', -1) do
      delete :destroy, id: @reward_order
    end

    assert_redirected_to reward_orders_path
  end
end
