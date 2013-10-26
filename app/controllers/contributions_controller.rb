class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy]

  # GET /contributions
  def index
    @contributions = Contribution.all
  end

  # GET /contributions/1
  def show
  end

  # GET /contributions/new
  def new
    @contribution = Contribution.new
  end

  # GET /contributions/1/edit
  def edit
  end

  # POST /contributions
  def create
    @contribution = Contribution.new(contribution_params)

    if @contribution.save
      redirect_to @contribution, notice: 'Contribution was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /contributions/1
  def update
    if @contribution.update(contribution_params)
      redirect_to @contribution, notice: 'Contribution was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /contributions/1
  def destroy
    @contribution.destroy
    redirect_to contributions_url, notice: 'Contribution was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribution
      @contribution = Contribution.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contribution_params
      params.require(:contribution).permit(:charity_split, :earthpact_split, :amount, :last_four, :payment_provider)
    end
end
