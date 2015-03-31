class WeeklyRetrospectsController < ApplicationController
  before_action :set_weekly_retrospect, only: [:show, :edit, :update, :destroy]

  # GET /weekly_retrospects
  # GET /weekly_retrospects.json
  def index
    @weekly_retrospects = WeeklyRetrospect.all
  end

  # GET /weekly_retrospects/1
  # GET /weekly_retrospects/1.json
  def show
  end

  # GET /weekly_retrospects/new
  def new
    @weekly_retrospect = WeeklyRetrospect.new
  end

  # GET /weekly_retrospects/1/edit
  def edit
  end

  # POST /weekly_retrospects
  # POST /weekly_retrospects.json
  def create
    @weekly_retrospect = WeeklyRetrospect.new(weekly_retrospect_params)

    respond_to do |format|
      if @weekly_retrospect.save
        format.html { redirect_to @weekly_retrospect, notice: 'Weekly retrospect was successfully created.' }
        format.json { render :show, status: :created, location: @weekly_retrospect }
      else
        format.html { render :new }
        format.json { render json: @weekly_retrospect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weekly_retrospects/1
  # PATCH/PUT /weekly_retrospects/1.json
  def update
    respond_to do |format|
      if @weekly_retrospect.update(weekly_retrospect_params)
        format.html { redirect_to @weekly_retrospect, notice: 'Weekly retrospect was successfully updated.' }
        format.json { render :show, status: :ok, location: @weekly_retrospect }
      else
        format.html { render :edit }
        format.json { render json: @weekly_retrospect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weekly_retrospects/1
  # DELETE /weekly_retrospects/1.json
  def destroy
    @weekly_retrospect.destroy
    respond_to do |format|
      format.html { redirect_to weekly_retrospects_url, notice: 'Weekly retrospect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weekly_retrospect
      @weekly_retrospect = WeeklyRetrospect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weekly_retrospect_params
      params.require(:weekly_retrospect).permit(:user_id, :weekly_goal_id, :rapidfire_answer_group_id)
    end
end
