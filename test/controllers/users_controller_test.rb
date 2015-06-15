require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @user2 = users(:two)
  end

  def nil_setup
    session[:user_id] = nil
  end

  def user_setup
    session[:user_id] = @user.id
  end

  def root
    assert_redirected_to root_path
  end

  def denied
    assert_equal "You do not have that authorization :p", flash[:notice]
  end

  def already_logged_in
    assert_equal "You must be logged in before accessing this site.", flash[:notice]
  end

  def success
    assert_response :success
  end

  test "should get index regardless of log in" do

    nil_setup
    get :index
    success
    assert_not_nil assigns(:users)

    user_setup
    get :index
    success

    assert_not_nil assigns(:users)
  end

  test "should get show regardless of log in" do

    nil_setup
    get :show, id: @user
    success

    user_setup
    get :show, id: @user

    success
  end

  test "should get new if not signed in" do
    nil_setup
    get :new
    success
  end

  test "should not get new and reroute to root if signed in" do
    user_setup
    get :new
    root
    already_logged_in
  end

  test "should create user if not signed in" do
    nil_setup
    assert_difference('User.count') do
      post :create, user: { email: @user.email.capitalize, name: @user.name, password: @user.password }
    end

    root
  end

  test "should not create user && reroute to root if signed in" do
    user_setup
    post :create, user: { email: @user.email.capitalize, name: @user.name, password: @user.password }
    root
    already_logged_in
  end

  test "should not get edit if signed out" do
    nil_setup
    get :edit, id: @user
    denied

    get :edit, id: @user2
    denied
  end

  test "should edit self" do
    user_setup
    get :edit, id: @user
    success
  end

  test "should not edit others" do
    user_setup
    get :edit, id: @user2
    denied
  end

  test "should not update if signed out" do
    nil_setup
    patch :update, id: @user, user: { email: @user.email, name: @user.name, password: @user.password }
    denied
  end

  test "should update self" do
    user_setup
    patch :update, id: @user, user: { email: @user.email, name: @user.name, password: @user.password }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should not update others" do
    user_setup
    patch :update, id: @user2, user: { email: @user2.email, name: @user2.name, password: @user2.password }
    assert_redirected_to root_path
    denied
  end

  test "should not delete if not signed in" do
    nil_setup
    delete :destroy, id: @user
    denied
  end

  test "should destroy self" do
    user_setup
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
    root
    assert_equal "User was successfully destroyed.", flash[:notice]
  end

  test "should not destroy other users" do
    user_setup
    delete :destroy, id: @user2
    root
    denied
  end
end
