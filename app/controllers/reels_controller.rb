class ReelsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :destory]
  before_action :corrent_user, only: [:destroy]

  def new
    @reel = current_user.reels.build
  end

  def create
    @reel = current_user.reels.build(reel_params).per(3)

    url = params[:reel][:youtube_url]
    # url = url.last(11)
    @reel.youtube_url = url

    if @reel.save 
      flash[:success] = '投稿しました。'
      redirect_to current_user
    else  
      @reels = current_user.feed_reels.order(id: :desc).page(params[:page])  
      flash.now[:danger] = 'リールの投稿に失敗しました。'
      redirect_to current_user
    end

  end

  def destroy
    @reel.destroy
    flash[:success] = '削除しました。'
    redirect_to current_user
  end



private

    def reel_params
        params.require(:reel).permit(:youtube_url)
    end
      
    def corrent_user
      @reel = current_user.reels.find_by(id: params[:id])
      unless @reel
        redirect_to current_user
      end
    end

end
