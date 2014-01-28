require 'test_helper'

class CampsitesControllerTest < ActionController::TestCase
  setup do
    @campsite = campsites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campsites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campsite" do
    assert_difference('Campsite.count') do
      post :create, campsite: { camp_phone: @campsite.camp_phone, camp_url: @campsite.camp_url, description: @campsite.description, name: @campsite.name, org: @campsite.org, res_phone: @campsite.res_phone, res_url: @campsite.res_url }
    end

    assert_redirected_to campsite_path(assigns(:campsite))
  end

  test "should show campsite" do
    get :show, id: @campsite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @campsite
    assert_response :success
  end

  test "should update campsite" do
    patch :update, id: @campsite, campsite: { camp_phone: @campsite.camp_phone, camp_url: @campsite.camp_url, description: @campsite.description, name: @campsite.name, org: @campsite.org, res_phone: @campsite.res_phone, res_url: @campsite.res_url }
    assert_redirected_to campsite_path(assigns(:campsite))
  end

  test "should destroy campsite" do
    assert_difference('Campsite.count', -1) do
      delete :destroy, id: @campsite
    end

    assert_redirected_to campsites_path
  end
end
