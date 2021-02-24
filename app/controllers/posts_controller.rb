class PostsController < ApplicationController
    before_action :require_user_logged_in
    before_action :corrent_user, only: [:destroy]

    def index
        @posts = Post.all                #ビューで投稿一覧を表示するために全取得。
        @post = current_user.posts.new   #ビューのform_withのmodelに使う。
    end
    
    def show
        @post = Post.find(params[:id])
        @comments = @post.comments
        @comment = Comment.new
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)
        
        if @post.save 
          flash[:success] = '投稿しました。'
          redirect_to current_user
        end
    end

    def destroy
        @post.destroy
        flash[:success] = '削除しました。'
        redirect_to current_user
        
    end

    private

    def post_params
        params.require(:post).permit(:content, :image)
        # if image = params[:content][:image]
        # @post.image.attach(image)
        # end
      end
      
      def corrent_user
        @post = current_user.posts.find_by(id: params[:id])
        unless @post
          redirect_to current_user
        end
      end
      

end
