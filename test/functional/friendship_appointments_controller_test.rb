require 'test_helper'

class FriendshipAppointmentsControllerTest < ActionController::TestCase
  setup do
    @friendship_appointment = friendship_appointments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friendship_appointments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create friendship_appointment" do
    assert_difference('FriendshipAppointment.count') do
      post :create, friendship_appointment: @friendship_appointment.attributes
    end

    assert_redirected_to friendship_appointment_path(assigns(:friendship_appointment))
  end

  test "should show friendship_appointment" do
    get :show, id: @friendship_appointment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @friendship_appointment.to_param
    assert_response :success
  end

  test "should update friendship_appointment" do
    put :update, id: @friendship_appointment.to_param, friendship_appointment: @friendship_appointment.attributes
    assert_redirected_to friendship_appointment_path(assigns(:friendship_appointment))
  end

  test "should destroy friendship_appointment" do
    assert_difference('FriendshipAppointment.count', -1) do
      delete :destroy, id: @friendship_appointment.to_param
    end

    assert_redirected_to friendship_appointments_path
  end
end
