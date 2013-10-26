require 'test_helper'

class PactsControllerTest < ActionController::TestCase
  setup do
    @pact = pacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pact" do
    assert_difference('Pact.count') do
      post :create, pact: { agreed: @pact.agreed, balance: @pact.balance, penalty: @pact.penalty }
    end

    assert_redirected_to pact_path(assigns(:pact))
  end

  test "should show pact" do
    get :show, id: @pact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pact
    assert_response :success
  end

  test "should update pact" do
    patch :update, id: @pact, pact: { agreed: @pact.agreed, balance: @pact.balance, penalty: @pact.penalty }
    assert_redirected_to pact_path(assigns(:pact))
  end

  test "should destroy pact" do
    assert_difference('Pact.count', -1) do
      delete :destroy, id: @pact
    end

    assert_redirected_to pacts_path
  end
end
