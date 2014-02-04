require 'test_helper'

class TribesControllerTest < ActionController::TestCase
  setup do
    @tribe = tribes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tribes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tribe" do
    assert_difference('Tribe.count') do
      post :create, tribe: { description: @tribe.description, name: @tribe.name, vibe: @tribe.vibe }
    end

    assert_redirected_to tribe_path(assigns(:tribe))
  end

  test "should show tribe" do
    get :show, id: @tribe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tribe
    assert_response :success
  end

  test "should update tribe" do
    patch :update, id: @tribe, tribe: { description: @tribe.description, name: @tribe.name, vibe: @tribe.vibe }
    assert_redirected_to tribe_path(assigns(:tribe))
  end

  test "should destroy tribe" do
    assert_difference('Tribe.count', -1) do
      delete :destroy, id: @tribe
    end

    assert_redirected_to tribes_path
  end
end
