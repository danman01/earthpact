class PactsController < ApplicationController
  before_action :set_pact, only: [:show, :edit, :update, :destroy]

  # GET /pacts
  def index
    @pacts = Pact.all
  end

  # GET /pacts/1
  def show
  end

  # GET /pacts/new
  def new
    @pact = Pact.new
  end

  # GET /pacts/1/edit
  def edit
  end

  # POST /pacts
  def create
    @pact = Pact.new(pact_params)
    # initial pact amounts
    @pact.penalty=0.25
    if @pact.balance.nil?
      # init balance
      @pact.balance = 0
    end
    if params[:user_email]
      user = current_user
      user.email = params[:user_email]
      user.save
    end
    if @pact.save
      redirect_to @pact, notice: 'Pact was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /pacts/1
  def update
    if @pact.update(pact_params)
      redirect_to @pact, notice: 'Pact was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /pacts/1
  def destroy
    @pact.destroy
    redirect_to pacts_url, notice: 'Pact was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pact
      @pact = Pact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pact_params
      params.require(:pact).permit(:agreed, :balance, :penalty,:user_id)
    end
end
