class SurveysController < ApplicationController
  include ApplicationHelper
  before_action :logged_in?, except: :index

  before_action :set_survey, only: [:show, :edit, :update, :destroy, :take, :submit]

  before_action :set_submission, only: [:take, :submit]

  def index
    @surveys = Survey.all
  end

  def take
    if request.patch?
      if @survey.update(submission_params)
        redirect_to surveys_path, notice: "Succesfully updated"
      end
    else
      @questions = @survey.questions.order(:order)
      @submission.answers.build
    end
  end

  def submit
    if request.post?
      if @submission.update(submission_params)
        redirect_to surveys_path, notice: "Thank you for your submission"
      end
    else
      redirect_to error_path
    end
  end

  def user_index
    @surveys = Survey.where(user_id: session[:user_id])
  end

  def publish
  end
  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
    @survey.questions.build
  end

  # GET /surveys/1/edit
  def edit
    @survey.questions.build
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params, user_id: session[:user_id])
    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
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

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def error

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    def set_submission
      submission_id = Submission.last.id + 1 rescue 0
      @submission = Submission.new(survey_id: @survey.id)
    end

    def survey_params
      params.require(:survey).permit(:title, :description, :published,
          questions_attributes: [:id, :survey_id, :order, :question_type,
              :value, :require, :_destroy,
          ]
      )
    end

    def submission_params
      params.require(:submission).permit(:id, :survey_id, answers_attributes:
        [:id, :question_id, :submission_id, :value]
      )
    end
end
