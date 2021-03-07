class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]

    def index
        @users = User.order(id: :desc).page(params[:page]).per(25)
    end

    def show
        @user = User.find(params[:id])

        @posts = @user.posts.order(id: :desc).page(params[:page]).per(6)
        counts(@user)

        @reels = @user.reels.order(id: :desc).page(params[:page]).per(6)
        counts(@user)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
          flash[:success] = "ユーザを登録しました"
          redirect_to @user
        else
          flash[:danger] = "登録に失敗しました"
          render :new
        end
    end

    def edit
      @user = User.find(params[:id])

      unless @user == current_user
        redirect_to  current_user
      end
    end

    def update
      @user = User.find(params[:id])
      
      if current_user == @user
         if @user.update(user_params)
          flash[:success] = "正常に更新されました"
          redirect_to current_user
         else
          flash.now[:danger] = "更新に失敗しました"
          render :edit
         end
      else
        redirect_to current_user
      end
      
    end  

    def followings
      @user = User.find(params[:id])
      @followings = @user.followings.page(params[:page])
      counts(@user)
    end
    
    def followers
      @user = User.find(params[:id])
      @followers = @user.followers.page(params[:page])
      counts(@user)
    end
      
    def likes
      # @user = User.favorites.find(:micropost)
      @user = User.find(params[:id])
      @likes = @user.likes.page(params[:page])
      counts(@user)
    end  


    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :avatar, :avatar_cache)
      end

end
