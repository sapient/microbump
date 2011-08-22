class SiteController < ApplicationController
  def index
    @posts = Post.published.order("published_at DESC")
  end

end
