class WeeksController < ApplicationController
  before_action :set_week, only: [:show, :edit, :update, :destroy]

  # GET /weeks
  def index
    @weeks = Week.all
  end

  # GET /weeks/1
  def show
  end

  # GET /weeks/new
  def new
    @week = Week.new
  end

  # GET /weeks/1/edit
  def edit
  end

  # POST /weeks
  def create
    @week = Week.new(week_params)

    if @week.save
      redirect_to @week, notice: 'Week was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /weeks/1
  def update
    if @week.update(week_params)
      redirect_to @week, notice: 'Week was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /weeks/1
  def destroy
    @week.destroy
    redirect_to weeks_url, notice: 'Week was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_week
      @week = Week.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def week_params
      params.require(:week).permit(:start_day, :end_day, :total_contributed, :total_used)
    end
end
