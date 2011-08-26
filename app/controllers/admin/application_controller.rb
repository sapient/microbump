class Admin::ApplicationController < ActionController::Base
  protect_from_forgery
  force_ssl

  layout "/admin/layouts/application"

  before_filter :authenticate

  private
  def current_user
    #logger.debug "Getting current user #{session[:user_id]}".green
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    logger.debug "CU #{@current_user}".green
    @current_user
  end

  def authenticate
    logger.debug "Authenticating - #{@current_user.inspect}".red
    redirect_to(admin_login_path) unless current_user
  end

  helper_method :current_user
end
