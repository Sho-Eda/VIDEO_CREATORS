class UsersController < ApplicationController

    def index
        @users = User.order(id: :desc)
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
          flash[:notice] = "ユーザを登録しました"
          redirect_to @user
        else
          flash[:notice] = "登録に失敗しました"
          render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end

end
