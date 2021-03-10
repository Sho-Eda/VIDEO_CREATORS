class ReelsController < ApplicationController
  before_action :require_user_logged_in, only: %i[new create destory edit update]
  before_action :corrent_user, only: [:destroy]

  def show
    @reel = Reel.find(params[:id])
  end

  def new
    @reel = current_user.reels.build
  end

  def create
    @reel = current_user.reels.build(reel_params)

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

  def edit
    @reel = Reel.find_by(id: params[:id])
  end

  def update
    @reel = Reel.find_by(id: params[:id])

    if @reel.update(reel_params)
      flash[:success] = '更新しました'
      redirect_to @reel

    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  private

  def reel_params
    params.require(:reel).permit(:youtube_url)
  end

  def corrent_user
    @reel = current_user.reels.find_by(id: params[:id])
    redirect_to current_user unless @reel
  end
end
