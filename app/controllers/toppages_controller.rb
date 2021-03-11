class ToppagesController < ApplicationController
  def index
    @posts = Post.all.order(id: :desc).page(params[:page]).per(6)
    @category = Category.where(ancestry: nil)
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
