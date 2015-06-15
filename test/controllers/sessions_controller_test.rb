require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
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

  test "should get new if not signed in" do
    nil_setup
    get :new
    success
  end

  test "should not get new if signed in" do
    user_setup
    get :new
    root
    already_logged_in
  end

  test "sign in successfully if not signed in" do
    nil_setup
    post :create, { email: @user.email, password: @user.password }
    root
    assert_equal "Log in successful.", flash[:notice]
  end

  test "incorrect password if not signed in" do
    nil_setup
    post :create, { email: @user.email, password: "incorrect password" }
    root
    assert_equal "Incorrect password.", flash[:notice]
  end

  test "incorrect email if not signed in" do
    nil_setup
    post :create, { email: "incorrect@email.com", password: @user.password }
    root
    assert_equal "ACCESS DENIED", flash[:notice]
  end

  test "should not get create if signed in" do
    user_setup
    get :create
    already_logged_in
  end

  test "should get destroy if signed in" do
    user_setup
    get :destroy
    root
    assert_equal "Log out successful.", flash[:notice]
  end

  test "should not get destroy if not signed" do
    nil_setup
    get :destroy
    assert_equal "Already logged out :p", flash[:notice]
  end

end
