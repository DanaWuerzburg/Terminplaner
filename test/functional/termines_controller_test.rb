require 'test_helper'

class TerminesControllerTest < ActionController::TestCase
  setup do
    @termine = termines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:termines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create termine" do
    assert_difference('Termine.count') do
      post :create, termine: @termine.attributes
    end

    assert_redirected_to termine_path(assigns(:termine))
  end

  test "should show termine" do
    get :show, id: @termine.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @termine.to_param
    assert_response :success
  end

  test "should update termine" do
    put :update, id: @termine.to_param, termine: @termine.attributes
    assert_redirected_to termine_path(assigns(:termine))
  end

  test "should destroy termine" do
    assert_difference('Termine.count', -1) do
      delete :destroy, id: @termine.to_param
    end

    assert_redirected_to termines_path
  end
end
