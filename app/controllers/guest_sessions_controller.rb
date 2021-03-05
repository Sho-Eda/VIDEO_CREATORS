class GuestSessionsController < ApplicationController
  skip_before_action :login_required, raise: false

  def create
    user=User.find_by(email:"test@example.com")
    session[:user_id] = user.id
    flash[:success] = "テストユーザとしてログインしました。"
    redirect_to user
  end

end
