class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]

  # GET /logs
  def index
    if current_user
      @logs = current_user.logs
    else
      @logs.all
    end
  end

  # GET /logs/1
  def show
    @total_plastic_used = @log.user.total_plastic_used
  end

  # GET /logs/new
  def new
    @log = Log.new
  end

  # GET /logs/1/edit
  def edit
  end

  # POST /logs
  # Create log entry and add totals to week (overall for app)
  def create
    @log = Log.new(log_params)
    @log.user_id = current_user.id
    # contribute to week (entire app)
    week = Week.current_week
    @log.week_id = week.id
    if @log.save
      # update week values from log entry
      week.update_with_log(@log)
      
      # deduct penalties from users' balance
      pact = current_user.pact
      pact.balance -= @log.amount_used * pact.penalty # something like $20 - 5*.25
      pact.save
      redirect_to @log, notice: 'Log was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /logs/1
  def update
    if @log.update(log_params)
      redirect_to @log, notice: 'Log was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /logs/1
  def destroy
    @log.destroy
    redirect_to logs_url, notice: 'Log was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def log_params
      params.require(:log).permit(:amount_used, :description)
    end
end
