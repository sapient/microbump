class Admin::SessionsController < Admin::ApplicationController
  #skip_before_filter :authenticate, :only => :new
  skip_before_filter :authenticate

  layout "admin/layouts/login"

  def new
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to admin_dashboard_url, :notice => "Logged in successfully!"
    else
      flash.now.alert = "Invalid email or password!"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out"
  end
end
