class ToppagesController < ApplicationController
  def index
    # if logged_in?
    # @post = current_user.posts.build  # form_with 用
    # @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
    @posts = Post.all.order(id: :desc).page(params[:page]).per(6)
    # end
  end

  def new_guest
    user = User.find_or_create_by(email: 'guest@example.com') do |u|
      u.password = SecureRandom.urlsafe_base64
      u.name = 'Guest'
    end
    log_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
