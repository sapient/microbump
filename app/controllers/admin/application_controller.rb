class Admin::ApplicationController < ActionController::Base
  protect_from_forgery
  layout "/admin/layouts/application"
  logger.debug "IN ADMIN".red
end
