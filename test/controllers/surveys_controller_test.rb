require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  setup do
    @survey = surveys(:one)
    @user = users(:one)
    @user2 = users(:two)
  end

  def nil_setup
    session[:user_id] = nil
  end

  def user_setup
    session[:user_id] = @user.id
  end

  def other_user_setup
    session[:user_id] = @user2.id
  end

  def root
    assert_redirected_to root_path
  end

  def denied
    assert_equal "ACCESS DENIED", flash[:notice]
  end

  def success
    assert_response :success
  end

  def must_sign_in
    assert_equal "Must sign in :p", flash[:notice]
  end

  test "should get index regardless of log in" do
    nil_setup
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)

    user_setup
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)

    other_user_setup
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)
  end

  test "should get new if signed in" do
    user_setup
    get :new
    success
  end

  test "should not get new if signed out" do
    nil_setup
    get :new
    root
    must_sign_in
  end

  test "should create if signed in" do
    user_setup
    assert_difference('Survey.count') do
      post :create, survey: { description: @survey.description, published: @survey.published, title: @survey.title, user_id: @survey.user_id }
    end

    assert_redirected_to mysurveys_path
  end

  test "should not create if signed out" do
    nil_setup
    post :create, survey: { description: @survey.description, published: @survey.published, title: @survey.title, user_id: @survey.user_id }
    root
    must_sign_in
  end

  test "should show survey regardless" do
    nil_setup
    get :show, id: @survey
    success

    user_setup
    get :show, id: @survey
    success

    other_user_setup
    get :show, id: @survey
    success
  end

  test "should edit own survey" do
    user_setup
    get :edit, id: @survey
    success
  end

  test "should not edit others surveys" do
    other_user_setup
    get :edit, id: @survey
    root
    denied
  end

  test "should not edit if logged out" do
    nil_setup
    get :edit, id: @survey
    root
    denied
  end

  test "should update own survey" do
    user_setup
    patch :update, id: @survey, survey: { description: @survey.description, published: @survey.published, title: @survey.title, user_id: @survey.user_id }
    assert_redirected_to surveys_path
  end

  test "should not update others survey" do
    other_user_setup
    patch :update, id: @survey, survey: { description: @survey.description, published: @survey.published, title: @survey.title, user_id: @survey.user_id }
    root
    denied
  end

  test "should not update if signed out" do
    nil_setup
    patch :update, id: @survey, survey: { description: @survey.description, published: @survey.published, title: @survey.title, user_id: @survey.user_id }
    root
    denied
  end

  test "should destroy own survey" do
    user_setup
    assert_difference('Survey.count', -1) do
      delete :destroy, id: @survey
    end
    root
  end

  test "should not destroy others survey" do
    other_user_setup
    delete :destroy, id: @survey
    root
    denied
  end

  test "should not destroy if signed out" do
    nil_setup
    delete :destroy, id: @survey
    root
    denied
  end

  test "results page" do
    nil_setup
    get :results, id: @survey
    success
    user_setup
    get :results, id: @survey
    success
    other_user_setup
    get :results, id: @survey
    success
  end

  test "error page" do
    nil_setup
    get :error
    success
    user_setup
    get :error
    success
    other_user_setup
    get :error
    success
  end

  test "take survey page" do
    nil_setup
    get :take, id: @survey
    success
    user_setup
    get :take, id: @survey
    success
    other_user_setup
    get :take, id: @survey
    success
  end

  # test "submit" do
  #   nil_setup
  #   post :submit, id: @survey
  #   root
  # end

  test "should get my surveys if signed in" do
    user_setup
    get :user_index
    success
  end

  test "should not get my surveys if signed out" do
    nil_setup
    get :user_index
    must_sign_in
  end

  test "should publish if signed in" do
    user_setup
    get :publish, id: @survey
    success
  end

  test "should not publish if signed out" do
    nil_setup
    get :publish, id: @survey
    denied
  end

  # test "should only publish if question survey has >1 question" do
  #   survey = Survey.create(user_id: @user.id, title: "title")
  #   survey.published = true
  #   refute survey.save
  # end

end
