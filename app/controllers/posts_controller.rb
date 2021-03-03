class PostsController < ApplicationController
    before_action :require_user_logged_in, only: [:new, :create, :destory, :edit, :update]
    before_action :corrent_user, only: [:destroy]

    # def index
    #   @posts = current_user.posts.order(id: :desc).page(params[:page])
    # end
    
    def show
        @post = Post.find(params[:id])
        @comments = @post.comments.page(params[:page]).per(3)
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
        else  
          @posts = current_user.feed_posts.order(id: :desc).page(params[:page])  
          flash.now[:danger] = 'メッセージの投稿に失敗しました。'
          redirect_to current_user
        end

    end

    def destroy
        @post.destroy
        flash[:success] = '削除しました。'
        redirect_to current_user
        
    end

    def edit
      @post = Post.find_by(id: params[:id])
    end
    
    def update
      @post = Post.find_by(id: params[:id])
      
      if @post.update(post_params)
        flash[:success] = '更新しました'
        redirect_to root_url
        
      else
        flash.now[:danger] = '更新されませんでした'
        render :edit
      end
    end

    # def download
    #   download_file_name = "public/master/master.txt"
    #   send_file download_file_name
    # end

    # def download
    #   post = Post.find(download_params[:id])
    #   image = post.image # imageはFugaUploaderオブジェクト
    #   send_data(image.read, filename: "download#{File.extname(image.path)}")
    # end
    
    # def download
    #   @post = Post.find(params[:id])
    #   filepath = @post.image.current_path
    #   stat = File::stat(filepath)
    #   send_file(filepath, :filename => @post.image_identifier, :length => stat.size)
    # end

    # def download
    #   file = params[:download_file]
    #   file_id = params[:download_id]
    #   file_name = ERB::Util.url_encode(file)
    #   @post = Post.find(params[:id])
    #   data = open("https://s3-ap-northeast-1.amazonaws.com/film-storage/uploads/post/image/#{file_id}/#{file_name}")
    #   send_data data.read, filename: file_name, disposition: 'attachment', stream: 'true', buffer_size: '4096'
    # end

    # def download
    #   file = params[:download_file]
    #   file_id = params[:download_id]
    #   file_name = ERB::Util.url_encode(file)
    #   data = open("https://s3-ap-northeast-1.amazonaws.com/film-storage/uploads/post/image/#{file_id}/#{file_name}")
    #   send_data data.read, filename: file_name, disposition: 'attachment', stream: 'true', buffer_size: '4096'
    # end

    # def download
    #   s3 = Aws::S3::Resource.new(
    #     access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    #     secret_access_key: ENV["AWS_SECRET_KEY"],
    #     region: ENV["AWS_REGION"]
    #     )
    #     @post = Post.find(params[:id])
    #     extension = @post.extension

   
    #   send_data "#{Rails.root}/imagetmp/#{@post.image_id}.#{extension}", x_sendfile: true
    # end

    private

    def post_params
        params.require(:post).permit(:content, :image)
    end
      
    def corrent_user
      @post = current_user.posts.find_by(id: params[:id])
      unless @post
        redirect_to current_user
      end
    end
      
    # def download_params
    #   params.permit(:id)
    # end

end
