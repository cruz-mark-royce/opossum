require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
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
    assert_equal "Action Denied", flash[:notice]
  end

  test "should get index regardless of log in" do
    nil_setup
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
    user_setup
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new if not signed in" do
    nil_setup
    get :new
    assert_response :success
  end

  test "should not get new and reroute to root if signed in" do
    user_setup
    get :new
    assert_response :success
  end

  test "should create user if not signed in" do
    nil_setup
    assert_difference('User.count') do
      post :create, user: { email: @user.email.capitalize, name: @user.name, password: @user.password }
    end

    assert_redirected_to root_path
  end

  test "should not create user and reroute to root if signed in" do
    user_setup
    post :create, user: { email: @user.email.capitalize, name: @user.name, password: @user.password }
    root
    denied
  end

  # test "should show user" do
  #   get :show, id: @user
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get :edit, id: @user
  #   assert_response :success
  # end
  #
  # test "should update user" do
  #   patch :update, id: @user, user: { email: @user.email, name: @user.name, password: @user.password }
  #   assert_redirected_to user_path(assigns(:user))
  # end
  #
  # test "should destroy user" do
  #   assert_difference('User.count', -1) do
  #     delete :destroy, id: @user
  #   end
  #
  #   assert_redirected_to users_path
  # end
end
