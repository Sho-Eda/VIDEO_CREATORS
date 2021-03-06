class ApplicationController < ActionController::Base

include SessionsHelper

 private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def counts(user)
    @count_posts = user.posts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_likes = user.likes.count
    @count_reels = user.reels.count
  end

  # def log_in(user)
  #   session[:user_id] = user.id
  # end

  # def guest_user
  #   current_user == User.find_by(email: 'guest@example.com')
  # end
end
