class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.all
  end

  def submit
    @survey = Survey.find(params[:survey_id])
  end

  def user_index

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
  end

  # GET /surveys/1/edit
  def edit
    @survey.questions.build
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:user_id, :title, :description, :published,
          questions_attributes: [:id, :survey_id, :order, :question_type, :value, :require, :_destroy]
      )
    end
end
