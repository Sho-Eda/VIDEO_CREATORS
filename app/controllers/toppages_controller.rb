class ToppagesController < ApplicationController
  def index
    if logged_in?
      @mpost = current_user.posts.build  # form_with 用
      @posts = current_user.posts.order(id: :desc)
    end
  end
end
