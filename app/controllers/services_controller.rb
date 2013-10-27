class ServicesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @providers     ||= omniauth_providers
    @user_services   = current_user.services
    @pact = Pact.new
  end

  def create
    current_service = Service.where(provider: omnihash[:provider], uid: omnihash[:uid]).first rescue nil
    puts "\n ========================= \n Omnihash: \n #{omnihash.to_yaml}\n =========================== \n"
    if logged_in?
      # logged in and either adding a new or linking new service
      if current_service
        flash[:notice] = I18n.t('notifications.provider_already_connected', provider: omnihash[:provider])
      else
        case omnihash[:provider] 
        when "twitter"
          current_user.services.create!(build_twitter_hash(omnihash))
        when "github"
          current_user.services.create!(build_github_hash(omnihash))
        when "yammer"
          current_user.services.create!(build_yammer_hash(omnihash))
        end

        flash[:notice] = I18n.t('notifications.provider_added', provider: omnihash[:provider])
      end
    else
      # not logged in and either finding existing service or creating
      # new service and then creating the session
      if current_service
        session[:user_id]            = current_service.user.id
        session[:service_id]         = current_service.id
        session[:oauth_token]        = omnihash[:credentials][:token]
        session[:oauth_token_secret] = omnihash[:credentials][:secret]
      else
        user         = User.new
        user.name    = omnihash[:info][:nickname] rescue nil
        user.name    = omnihash[:info][:name] if omnihash[:provider].to_s == "developer"
        user.email   = omnihash[:info][:email]
        case omnihash[:provider] 
        when "twitter"
          user_service = user.services.build(build_twitter_hash(omnihash))
        when "github"
          user_service = user.services.build(build_github_hash(omnihash))
        when "yammer"
          user_service = user.services.build(build_yammer_hash(omnihash))
        end


        if user.save!
          # log user in
          session[:user_id]            = user.id
          session[:service_id]         = user_service.id
          session[:oauth_token]        = omnihash[:credentials][:token]
          session[:oauth_token_secret] = omnihash[:credentials][:secret]

          flash[:notice] = I18n.t('notifications.account_created')
        end
      end
    end

    redirect_to root_url 
  end

  def destroy
    service = current_user.services.find(params[:id])
    if service.respond_to?(:destroy) and service.destroy
      flash[:notice] = I18n.t('notifications.provider_unlinked', provider: service.provider)
      redirect_to redirect_path
    end
  end

  def failure
    flash[:error] = I18n.t('notifications.authentication_error')
    redirect_to root_url
  end

  private

  def build_twitter_hash(omnihash)
    {
      provider: omnihash[:provider],
      uid: omnihash[:uid],
      #nickname: omnihash[:info][:nickname],
      #access_token: omnihash[:credentials][:token],
      image: omnihash[:info][:image]
    }
  end

  def build_github_hash(omnihash)
    {
      provider: omnihash[:provider],
      uid: omnihash[:uid]
    }
  end

  def build_yammer_hash(omnihash)
    {
      provider: omnihash[:provider],
      uid: omnihash[:uid]
    }
  end

  def omnihash
    request.env['omniauth.auth']
  end

  def omniauth_providers
    (OmniAuth::Strategies.local_constants.map(&:downcase) - %i(developer oauth oauth2)).map(&:to_s)
  end

  def redirect_path
    :services
  end
end
