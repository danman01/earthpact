class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy]
  skip_filter :verify_authenticity_token, :only => [:create]

  # GET /contributions
  def index
    @contributions = Contribution.all
  end

  # GET /contributions/1
  def show
    @log = current_user.logs.build
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
    # create contribution params
    params.merge!({:contribution => {:charity_split=>0.95, :earthpact_split=>0.05, :amount=>20.00, :last_four=>params[:last_four], :payment_provider=>"Stripe"}})

    @contribution = Contribution.new(contribution_params)
    @contribution.user_id = current_user.id
    
    Stripe.api_key = Contribution::STRIPE_SECRET_KEY 

    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create a Customer
    customer = Stripe::Customer.create(
      :card => token,
      :description => current_user.email
    )

    # Charge the Customer instead of the card
    Stripe::Charge.create(
        :amount => 2000, # in cents
        :currency => "usd",
        :customer => customer.id
    )

    # Save the customer ID in your database so you can use it later
    current_user.save_stripe_customer_id(customer.id)

    # Later...
    #customer_id = user.get_stripe_customer_id

    #Stripe::Charge.create(
    #  :amount   => 1500, # $15.00 this time
    #  :currency => "usd",
    #  :customer => customer_id
    #)

    if @contribution.save
      # credit the users' pact balance with the contribution amount
      pact = current_user.pact
      pact.balance += @contribution.amount
      pact.save

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
      params.require(:contribution).permit(:charity_split, :earthpact_split, :amount, :last_four, :payment_provider,:user_id)
    end
end
