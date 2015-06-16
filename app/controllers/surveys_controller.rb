class SurveysController < ApplicationController

  include SurveysHelper

  # logged_in checks if user is logged in AND if the survey is theirs
  before_action :logged_in, only: [:edit, :update, :destroy, :publish]

  # logged_in_at_all only checks if user is logged in
  before_action :logged_in_at_all, only: [:user_index, :new, :create]

  before_action :set_user

  before_action :set_survey, only: [:show, :edit, :update, :destroy, :take, :submit, :results, :publish]

  before_action :set_submission, only: [:take, :submit]

  before_action :set_questions, only: :results

  #add after action for checking to
  # if @survey.questions.first.results.count != 0
  #   redirect_to root_path, notice: "Sruvey has already been taken. No updates allowed"
  # end

  def index
    @surveys = Survey.all
  end

  def take
    if request.patch?
      if @survey.update(submission_params)
        redirect_to surveys_path, notice: 'Succesfully updated'
      end
    else
      @questions = @survey.questions.order(:order)
      @submission.answers.build
    end
  end

  def submit
    if request.post?
      if @submission.update(submission_params)
        redirect_to surveys_path, notice: 'Thank you for your submission'
      end
    else
      redirect_to error_path
    end
  end

  def user_index
    @surveys = Survey.where(user_id: session[:user_id])
  end

  def publish
    # if @surve
  end

  def show
  end

  def new
    @survey = Survey.new
    @survey.questions.build
  end

  def edit
    @survey.questions.build
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.user_id = session[:user_id]
    respond_to do |format|
      if @survey.save
        format.html { redirect_to mysurveys_path, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        @survey.questions.build
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @survey.update(survey_params)
        if params[:commit] == 'Publish'
          @survey.update(published: true)
          format.html { redirect_to "/publish/#{@survey.id}", notice: 'Survey was successfully published.' }
        elsif params[:commit] == 'Unpublish'
          @survey.update(published: false)
          format.html { redirect_to surveys_path, notice: 'Survey was successfully unpublished.' }
        else
          format.html { redirect_to surveys_path, notice: 'Survey was successfully updated.' }
          format.json { render :show, status: :ok, location: @survey }
        end
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def error
  end

  def results

  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def set_submission
    submission_id = Submission.last.id + 1 rescue 0
    @submission = Submission.new(survey_id: @survey.id)
  end

  def set_user
    @user = User.find(session[:user_id]) rescue nil
  end

  def set_questions
    @questions = @survey.questions.order(:order)
  end

  def survey_params
    params.require(:survey).permit(:user_id, :title, :description, :published,
                                   questions_attributes: [:id, :survey_id, :order, :question_type,
                                                          :value, :require, :_destroy
                                                         ]
                                  )
  end

  def submission_params
    params.require(:submission).permit(:id, :survey_id, answers_attributes:
      [:id, :question_id, :submission_id, :value]
                                      )
  end
end
